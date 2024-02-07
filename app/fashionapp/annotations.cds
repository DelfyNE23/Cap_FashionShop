using fashionShop_Service as service from '../../srv/fashionShop_srv';

annotate service.Fashion_Items with @(UI: {

    //ocultar campos sensibles de odata.draft. Ocultará loc campos create, delete, y update poniendo a true
    UpdateHidden           : false,
    CreateHidden           : false,
    DeleteHidden           : false, //true si no está permitido


    //Filtro para campos de búsqueda
    SelectionFields: [
        fashionType_id,
        itemname,
        brand,
        size,
        price
    ],

    //Filtro para información de cabecera
    HeaderInfo     : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Online Fashion Shop',
        TypeNamePlural: 'Online Fashion Shop',
        Title         : {Value: itemname},
        Description   : {Value: 'Online Fashion Shop'}
    },

    //Campos a mostrar en la fila de cada objeto
    LineItem       : [
        {Value: itemname},
        {Value: fashionType.section.name},
        {Value: fashionType.typename},
        {Value: brand},
        {Value: material},
        {Value: size},
        {Value: price},
        {Value: currency_code}
    ],

    //Facet--> Object Page
    Facets  : [
        {
            $Type : 'UI.CollectionFacet',
            ID    : '1',
            Label : 'Fashion Type & Section',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#TypeSection'
            }],
        },
        {
            $Type : 'UI.CollectionFacet',
            ID    : '2',
            Label : 'Fashion Item Details',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#ItemDetails',
                //![@UI.PartOfPreview] : false //para que lo oculte por defecto
            }],
        }
    ],

    FieldGroup #TypeSection: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Value: fashionType_id               
            },
            {
                Value: fashionType.typename,
                ![@Common.FieldControl] : #ReadOnly           
            },
            {
                Value: fashionType.description,
                ![@Common.FieldControl] : #ReadOnly              
            },
            {
                Value: fashionType.section.id,
                ![@Common.FieldControl] : #ReadOnly               
            },
            {
                Value: fashionType.section.name,
                ![@Common.FieldControl] : #ReadOnly               
            }
        ]
    },
    FieldGroup #ItemDetails: {Data: [
        {Value: id},
        { Value: itemname},
        {Value: brand},
        {Value: material},
        {Value: size},
        {Value: price},
        {Value: currency_code}
    ]},
});

annotate service.Fashion_Items with {
    fashionType @(
        //title         : 'Fashion type ID',
        sap.valie.list: 'fixed-values',
        Common        : {
            ValueListWithFixedValues,
            ValueList: {
                $Type         : 'Common.ValueListType',
                // CollectionPath: 'Fashion_Types' pero no nos da acceso directo a section.name
                CollectionPath: 'Srv_FashionShop',  
                     Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty: 'fashionTypeId',
                        LocalDataProperty: 'fashionType_id'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'sectionName'
                        
                    },
                     {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'fashionTypeName'
                        
                    }
                ]
            },

        }
    )
};

/*
annotate service.Fashion_Items with {
    fashionType @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Fashion_Types',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : fashionType_id,
                ValueListProperty : 'id',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'typename',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'description',
            },
        ],
    }
};
annotate service.Fashion_Items with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'itemname',
                Value : itemname,
            },
            {
                $Type : 'UI.DataField',
                Label : 'brand',
                Value : brand,
            },
            {
                $Type : 'UI.DataField',
                Label : 'size',
                Value : size,
            },
            {
                $Type : 'UI.DataField',
                Label : 'material',
                Value : material,
            },
            {
                $Type : 'UI.DataField',
                Label : 'price',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Value : currency_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'isAvailable',
                Value : isAvailable,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);*/
