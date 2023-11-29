//@AbapCatalog.sqlViewName: 'ZCDS_CALISMA2'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS İkinci Ödev'
define view entity ZCDS_MELIH_ODEV_2
  as select from    I_BillingDocumentBasic     as Billing_head
    inner join      I_BillingDocumentItemBasic as Billing_Item on Billing_Item.BillingDocument = Billing_head.BillingDocument
    left outer join vbak                       as vbak         on vbak.vbeln = Billing_head.BillingDocument

{
//  key Billing_Item.BillingDocument,
//  key Billing_Item.BillingDocumentItem ,
//      Billing_Item.SalesDocument,
//      Billing_Item.SalesDocumentItem,
      vbak.kunnr
}
