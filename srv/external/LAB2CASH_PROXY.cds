/* checksum : 69c2ec8051b5c5ca2cdc1c77f2b626ce */
@cds.external : true
@cds.persistence.skip : true
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.UpdateRestrictions.Updatable : false
entity LAB2CASH_PROXY.A_BusinessPartner {
  key BusinessPartner : String(10) not null;
  Customer : String(10);
  Supplier : String(10);
  AcademicTitle : String(4);
  AuthorizationGroup : String(4);
  BusinessPartnerCategory : String(1);
  BusinessPartnerFullName : String(81);
  BusinessPartnerGrouping : String(4);
  BusinessPartnerName : String(81);
  BusinessPartnerUUID : UUID;
  CorrespondenceLanguage : String(2);
  CreatedByUser : String(12);
  CreationDate : Date;
  CreationTime : Time;
  FirstName : String(40);
  FormOfAddress : String(4);
  Industry : String(10);
  InternationalLocationNumber1 : String(7);
  InternationalLocationNumber2 : String(5);
  IsFemale : Boolean;
  IsMale : Boolean;
  IsNaturalPerson : String(1);
  IsSexUnknown : Boolean;
  Language : String(2);
  LastChangeDate : Date;
  LastChangeTime : Time;
  LastChangedByUser : String(12);
  LastName : String(40);
  LegalForm : String(2);
  OrganizationBPName1 : String(40);
  OrganizationBPName2 : String(40);
  OrganizationBPName3 : String(40);
  OrganizationBPName4 : String(40);
  OrganizationFoundationDate : Date;
  OrganizationLiquidationDate : Date;
  SearchTerm1 : String(20);
  AdditionalLastName : String(40);
  BirthDate : Date;
  BusinessPartnerIsBlocked : Boolean;
  BusinessPartnerType : String(4);
  ETag : String(26);
  GroupBusinessPartnerName1 : String(40);
  GroupBusinessPartnerName2 : String(40);
  IndependentAddressID : String(10);
  InternationalLocationNumber3 : String(1);
  MiddleName : String(40);
  NameCountry : String(3);
  NameFormat : String(2);
  PersonFullName : String(80);
  PersonNumber : String(10);
  IsMarkedForArchiving : Boolean;
  BusinessPartnerIDByExtSystem : String(20);
  TradingPartner : String(6);
};

@cds.external : true
@cds.persistence.skip : true
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.UpdateRestrictions.Updatable : false
entity LAB2CASH_PROXY.A_Product {
  key Product : String(40) not null;
  ProductType : String(4);
  CrossPlantStatus : String(2);
  CrossPlantStatusValidityDate : Date;
  CreationDate : Date;
  CreatedByUser : String(12);
  LastChangeDate : Date;
  LastChangedByUser : String(12);
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  LastChangeDateTime : Timestamp;
  IsMarkedForDeletion : Boolean;
  ProductOldID : String(40);
  GrossWeight : Decimal(13, 3);
  PurchaseOrderQuantityUnit : String(3);
  SourceOfSupply : String(1);
  WeightUnit : String(3);
  NetWeight : Decimal(13, 3);
  CountryOfOrigin : String(3);
  CompetitorID : String(10);
  ProductGroup : String(9);
  BaseUnit : String(3);
  ItemCategoryGroup : String(4);
  ProductHierarchy : String(18);
  Division : String(2);
  VarblPurOrdUnitIsActive : String(1);
  VolumeUnit : String(3);
  MaterialVolume : Decimal(13, 3);
  ANPCode : String(9);
  Brand : String(4);
  ProcurementRule : String(1);
  ValidityStartDate : Date;
  LowLevelCode : String(3);
  ProdNoInGenProdInPrepackProd : String(40);
  SerialIdentifierAssgmtProfile : String(4);
  SizeOrDimensionText : String(32);
  IndustryStandardName : String(18);
  ProductStandardID : String(18);
  InternationalArticleNumberCat : String(2);
  ProductIsConfigurable : Boolean;
  IsBatchManagementRequired : Boolean;
  ExternalProductGroup : String(18);
  CrossPlantConfigurableProduct : String(40);
  SerialNoExplicitnessLevel : String(1);
  ProductManufacturerNumber : String(40);
  ManufacturerNumber : String(10);
  ManufacturerPartProfile : String(4);
  QltyMgmtInProcmtIsActive : Boolean;
  ChangeNumber : String(12);
  MaterialRevisionLevel : String(2);
  HandlingIndicator : String(4);
  WarehouseProductGroup : String(4);
  WarehouseStorageCondition : String(2);
  StandardHandlingUnitType : String(4);
  SerialNumberProfile : String(4);
  AdjustmentProfile : String(3);
  PreferredUnitOfMeasure : String(3);
  IsPilferable : Boolean;
  IsRelevantForHzdsSubstances : Boolean;
  QuarantinePeriod : Decimal(3, 0);
  TimeUnitForQuarantinePeriod : String(3);
  QualityInspectionGroup : String(4);
  AuthorizationGroup : String(4);
  HandlingUnitType : String(4);
  HasVariableTareWeight : Boolean;
  MaximumPackagingLength : Decimal(15, 3);
  MaximumPackagingWidth : Decimal(15, 3);
  MaximumPackagingHeight : Decimal(15, 3);
  UnitForMaxPackagingDimensions : String(3);
  to_Description : Association to many LAB2CASH_PROXY.A_ProductDescription {  };
};

@cds.external : true
@cds.persistence.skip : true
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.UpdateRestrictions.Updatable : false
entity LAB2CASH_PROXY.A_ProductDescription {
  key Product : String(40) not null;
  key Language : String(2) not null;
  ProductDescription : String(40);
};

@cds.external : true
@cds.persistence.skip : true
entity LAB2CASH_PROXY.A_SalesOrder {
  key SalesOrder : String(10) not null;
  SalesOrderType : String(4);
  SalesOrganization : String(4);
  DistributionChannel : String(2);
  OrganizationDivision : String(2);
  SalesGroup : String(3);
  SalesOffice : String(4);
  SalesDistrict : String(6);
  SoldToParty : String(10);
  CreationDate : Date;
  CreatedByUser : String(12);
  LastChangeDate : Date;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  LastChangeDateTime : Timestamp;
  PurchaseOrderByCustomer : String(35);
  CustomerPurchaseOrderType : String(4);
  CustomerPurchaseOrderDate : Date;
  SalesOrderDate : Date;
  TotalNetAmount : Decimal(16, 3);
  TransactionCurrency : String(5);
  SDDocumentReason : String(3);
  PricingDate : Date;
  RequestedDeliveryDate : Date;
  ShippingCondition : String(2);
  CompleteDeliveryIsDefined : Boolean;
  ShippingType : String(2);
  HeaderBillingBlockReason : String(2);
  DeliveryBlockReason : String(2);
  IncotermsClassification : String(3);
  IncotermsTransferLocation : String(28);
  IncotermsLocation1 : String(70);
  IncotermsLocation2 : String(70);
  IncotermsVersion : String(4);
  CustomerPaymentTerms : String(4);
  PaymentMethod : String(1);
  AssignmentReference : String(18);
  ReferenceSDDocument : String(10);
  ReferenceSDDocumentCategory : String(4);
  CustomerTaxClassification1 : String(1);
  TaxDepartureCountry : String(3);
  VATRegistrationCountry : String(3);
  SalesOrderApprovalReason : String(4);
  SalesDocApprovalStatus : String(1);
  OverallSDProcessStatus : String(1);
  TotalCreditCheckStatus : String(1);
  OverallTotalDeliveryStatus : String(1);
  OverallSDDocumentRejectionSts : String(1);
  to_Item : Association to many LAB2CASH_PROXY.A_SalesOrderItem {  };
};

@cds.external : true
@cds.persistence.skip : true
entity LAB2CASH_PROXY.A_SalesOrderItem {
  key SalesOrder : String(10) not null;
  key SalesOrderItem : String(6) not null;
  HigherLevelItem : String(6);
  SalesOrderItemCategory : String(4);
  SalesOrderItemText : String(40);
  PurchaseOrderByCustomer : String(35);
  Material : String(40);
  MaterialByCustomer : String(35);
  PricingDate : Date;
  RequestedQuantity : Decimal(15, 3);
  RequestedQuantityUnit : String(3);
  ItemGrossWeight : Decimal(15, 3);
  ItemNetWeight : Decimal(15, 3);
  ItemWeightUnit : String(3);
  ItemVolume : Decimal(15, 3);
  ItemVolumeUnit : String(3);
  TransactionCurrency : String(5);
  NetAmount : Decimal(16, 3);
  MaterialGroup : String(9);
  MaterialPricingGroup : String(2);
  Batch : String(10);
  ProductionPlant : String(4);
  StorageLocation : String(4);
  DeliveryGroup : String(3);
  ShippingPoint : String(4);
  ShippingType : String(2);
  DeliveryPriority : String(2);
  IncotermsClassification : String(3);
  IncotermsTransferLocation : String(28);
  IncotermsLocation1 : String(70);
  IncotermsLocation2 : String(70);
  CustomerPaymentTerms : String(4);
  SalesDocumentRjcnReason : String(2);
  ItemBillingBlockReason : String(2);
  WBSElement : String(24);
  ProfitCenter : String(10);
  ReferenceSDDocument : String(10);
  ReferenceSDDocumentItem : String(6);
  SDProcessStatus : String(1);
  DeliveryStatus : String(1);
  OrderRelatedBillingStatus : String(1);
  RequirementSegment : String(40);
  to_SalesOrder : Association to one LAB2CASH_PROXY.A_SalesOrder {  };
};

@cds.external : true
service LAB2CASH_PROXY {};

