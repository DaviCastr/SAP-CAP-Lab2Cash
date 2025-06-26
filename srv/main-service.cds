using { LAB2CASH_PROXY } from './external/LAB2CASH_PROXY';
using { cap.l2l.lab2cash as db } from '../db/schema';

service Main @(path: '/main'){

    //Dados do serviço proxy
    @restrict: [{
        grant:[
            'CREATE',
            'READ'
        ]
    }]
    entity A_SalesOrder as projection on LAB2CASH_PROXY.A_SalesOrder;

    extend projection A_SalesOrder with {
        to_Item: redirected to A_SalesOrderItem,
        Order: Association to one Orders on Order.sales_order_id = SalesOrder
    }

    @restrict: [{
        grant:[
            'CREATE',
            'READ'
        ]
    }]
    entity A_SalesOrderItem as projection on LAB2CASH_PROXY.A_SalesOrderItem;

    @readonly
    entity A_BusinessPartner as projection on LAB2CASH_PROXY.A_BusinessPartner;

    @readonly
    entity A_Product as projection on LAB2CASH_PROXY.A_Product {
        *,
        to_Description: redirected to A_ProductDescription
    };

    @readonly
    entity A_ProductDescription as projection on LAB2CASH_PROXY.A_ProductDescription;

    //Dados do banco de dados hana desse projeto:
     @restrict: [{
        grant:[
            'CREATE',
            'READ'
        ]
    }]
    entity Orders as projection on db.Orders;

    @restrict: [{
        grant:[
            'CREATE',
            'READ'
        ]
    }]
    entity Customers as projection on db.Customers;

    @restrict: [{
        grant:[
            'CREATE',
            'READ'
        ]
    }]
    entity Wallets as projection on db.Wallets;

    @restrict: [{
        grant:[
            'UPDATE',
            'READ'
        ]
    }]
    entity Parameters as projection on db.Parameters;

    //Funções
    function getParameters() returns Parameters;
    
    //Actions
    action updateParameters(parameters: Parameters) returns Parameters;

}
