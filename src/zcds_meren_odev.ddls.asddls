@AbapCatalog.sqlViewName: 'ZCDSMERENVIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Odev 2'

define view ZCDS_MEREN_ORDER
  as select from    I_PurchaseOrder     as PurchaseOrder
    inner join      I_PurchaseOrderItem as PurchaseOrderItem on PurchaseOrderItem.PurchaseOrder = PurchaseOrder.PurchaseOrder
    inner join      I_Product           as Product           on Product.Product = PurchaseOrderItem.Material
    inner join      I_Supplier          as Supplier          on Supplier.Supplier = PurchaseOrder.Supplier
    inner join      I_BillingDocument   as billing_docu      on billing_docu.BillingDocument = PurchaseOrder.PurchaseOrder
    left outer join iprodtext           as PRODTEXT          on PRODTEXT.product = Product.Product

{
  key PurchaseOrderItem.PurchaseOrder,
  key PurchaseOrderItem.PurchaseContractItem
      //      billing_docu.BillingDocumentDate
}
