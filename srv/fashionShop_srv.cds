using app.fasionShop from '../db/fashionShop';

//sólo podrán acceder a nuestro servicio los usuarios que estén autenticados
service fashionShop_Service  {
    entity Sections as projection on fasionShop.Sections;

    entity Fashion_Types as projection on fasionShop.Fashion_Types;

    entity Fashion_Items  as projection on fasionShop.Fashion_Items;
        annotate Fashion_Items with @odata.draft.enabled;

    entity Srv_FashionShop as projection on fasionShop.YC_FashionShop;
        annotate Srv_FashionShop with @odata.draft.enabled;

}
