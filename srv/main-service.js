const cds = require('@sap/cds');
const { aspect } = require('@sap/cds/lib/core/classes');

module.exports = (async (srv) => {

    const { A_BusinessPartner, A_SalesOrder, A_Product, Customers, Wallets, Orders, Parameters } = srv.entities;

    //Other form to get the entities from the database
    const db = await cds.connect.to('db');
    const dbe = db.entities;

    const proxyS4 = await cds.connect.to('LAB2CASH_PROXY');
    const s4e = proxyS4.entities;

    //Reads
    srv.on('READ', A_BusinessPartner, (req) => proxyS4.run(req.query));

    srv.on('READ', A_SalesOrder, (req) => proxyS4.run(req.http.req.url));

    srv.on('READ', A_Product, (req) => proxyS4.run(req.http.req.url));

    //Creates
    srv.before('CREATE', A_SalesOrder, async (req) => {

        const { PurchaseOrderByCustomer, TotalNetAmount, Order } = req.data;

        //1 - Stay using cashback? The cashback is activeted?
        const oParameters = await SELECT.one.from(Parameters);

        if (Order.applied_cashback > 0 && !oParameters.is_cashback_active) {
            return req.error(422, 'Cashback is not active.');
        }


        //2 - The business partner exists on S/4?
        const oBusinessPartner = await proxyS4.run(
            SELECT.one(A_BusinessPartner).where({ BusinessPartner: PurchaseOrderByCustomer })
        );

        if (!oBusinessPartner) {
            return req.error(422, `Business Partner ${PurchaseOrderByCustomer} Doesn't exists .`);
        }


        //3 - The customer exists on Hana/Local hana development?
        let oCustomer = await SELECT.one`from ${Customers} {
            *,
            wallet {
                *
            } 
        }`.where({ business_partner_id: PurchaseOrderByCustomer });

        if (!oCustomer) {

            const oCustomerCreate = await INSERT.into(Customers).entries({
                business_partner_id: PurchaseOrderByCustomer,
                wallet: {
                    balance: 0
                }
            })

            console.log(`Customer created: ${oCustomerCreate}`);

            oCustomer = await SELECT.one`from ${Customers} {
                *,
                wallet {
                    * 
                } 
            }`.where({ business_partner_id: PurchaseOrderByCustomer });

        }


        //4 - Does stay using cashback? Does have balance available in the wallet?
        if (Order.applied_cashback > oCustomer.wallet.balance) {
            return req.error(422, `The cashback applied is greater than the available balance`);
        }

        //5 - Does stay using cashback? The cashback excede the cashback limit of redemp?
        const oAllowedRedemptionLimit = TotalNetAmount * oParameters.cashback_redemption_limit;

        if (Order.applied_cashback > oAllowedRedemptionLimit) {
            return req.error(422, `Cashback redemption limit exceed.`);
        }

    });


    srv.on('CREATE', A_SalesOrder, async (req) => {

        const {
            SalesOrderType,
            SoldToParty,
            PurchaseOrderByCustomer,
            TotalNetAmount,
            to_Item,
            Order
        } = req.data;

        //1 - Do the selects
        const oCustomer = await SELECT.one`from ${Customers} {
            *,
            wallet {
                * 
            } 
        } where business_partner_id = ${PurchaseOrderByCustomer}`;

        //Total amount in cents
        const oOrderAmountInCents = (TotalNetAmount * 100) - Order.applied_cashback;

        //Total amount of cashback
        const oParameters = await SELECT.one(Parameters);
        const oReceivedCashbackInCents = oOrderAmountInCents * (oParameters.cashback_return / 100);

        //2 - Create the Sales order on S/4
        const oSalesOrderCreate = await proxyS4.run(
            INSERT({
                SalesOrderType,
                SoldToParty,
                PurchaseOrderByCustomer,
                TotalNetAmount,
                to_Item
            }).into(A_SalesOrder)
        );

        //3 - Create the transactions
        const oTransactions = [];

        if (Order.applied_cashback > 0) {

            oTransactions.push({
                type: 'REDEMPTION',
                amount: Order.applied_cashback,
                wallet: {
                    ID: oCustomer.wallet.ID
                }
            });

        }

        if (oReceivedCashbackInCents > 0) {

            oTransactions.push({
                type: 'CREDIT',
                amount: oReceivedCashbackInCents,
                wallet: {
                    ID: oCustomer.wallet.ID
                }
            });

        }

        //4 - Create the order in hana cap
        const oOrderCreate = await INSERT({
            sales_order_id: oSalesOrderCreate.SalesOrder,
            applied_cashback: Order.applied_cashback,
            amount: oOrderAmountInCents,
            customer_ID: oCustomer.ID,
            transactions: oTransactions
        }).into(Orders);

        console.log(`Oorder created: ${oOrderCreate}`);

        //5 - Update the balance ot the wallet
        const oTransactionsAmount = oTransactions.reduce((accumulator, current) => {
            const oValue = current.type === 'REDEMPTION'
                ? accumulator - current.amount
                : accumulator + current.amount;

            return oValue;
        }, 0);

        const oUpdateBalance = oCustomer.wallet.balance + oTransactionsAmount;

        await UPDATE(Wallets, oCustomer.wallet.ID)
            .set({ balance: oUpdateBalance });
        //OR .where({ID: oCustomer.wallet.ID})

        console.log(`Wallet balance updated: $ ${(oUpdateBalance / 100).toFixed(2)}.`);

        await srv.emit('balanceUpdated', { wallet_ID: oCustomer.wallet.ID});

        return oSalesOrderCreate;

    });


    //Functions
    srv.on('getParameters', async (req) => {

        //Or dbe.Parameters
        const oParameters = await SELECT.one.from(Parameters);

        return oParameters;

    });

    //Actions
    srv.on('updateParameters', async (req) => {

        const { parameters } = req.data;

        await UPDATE(Parameters).set(parameters);

        return parameters;
    });

    //Events
    srv.on('balanceUpdated', async (req) => {

        const { wallet_ID } = req.data;

        const oWallet = await SELECT.one(Wallets).where({ ID: wallet_ID });

        console.log(oWallet);

    })


});
