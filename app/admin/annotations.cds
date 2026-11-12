using AdminService as service from '../../srv/admin-service';

annotate service.Games with @(
    UI.SelectionFields: [
        title,
        genre_code,
        platform_code
    ],
    UI.LineItem       : [
        {
            Value: title,
            Label: 'Titel'
        },
        {
            Value: genre_code,
            Label: 'Genre'
        },
        {
            Value: platform_code,
            Label: 'Platform'
        },
        {
            Value: price,
            Label: 'Prijs'
        },
        {
            Value: stock,
            Label: 'Voorraad',
            Criticality: stockCriticality
        },
        {
            Value: releaseDate,
            Label: 'Release'
        }
    ]
);

annotate service.Games with {
    genre     @title                 : 'Genre'     @Common.Text: genre.name
              @Common.TextArrangement: #TextOnly;
    platform  @title                 : 'Platform'  @Common.Text: platform.name
              @Common.TextArrangement: #TextOnly;
    stock     @Common.Text           : stockStatus
              @Common.TextArrangement: #TextOnly;
};

annotate service.Games with @(
 UI.HeaderInfo : { TypeName: 'Game', TypeNamePlural: 'Games', Title: {
Value: title } },
 UI.FieldGroup #Algemeen : { Data: [
 { Value: title }, { Value: genre_code }, { Value: platform_code },
 { Value: releaseDate }, { Value: description } ] },
 UI.FieldGroup #Verkoop : { Data: [
 { Value: price }, { Value: currency_code }, { Value: stock, Label: 'Voorraad', Criticality: stockCriticality } ] },
 UI.Facets : [
 { $Type: 'UI.ReferenceFacet', ID: 'Algemeen', Label: 'Algemeen',
Target: '@UI.FieldGroup#Algemeen' },
{ $Type: 'UI.ReferenceFacet', ID: 'Verkoop', Label: 'Prijs en voorraad', Target: '@UI.FieldGroup#Verkoop' }
 ]
);

annotate service.Reviews with @(
    UI.LineItem: [
        { Value: rating_code, Label: 'Rating' },
        { Value: comment, Label: 'Commentaar' },
        { Value: customer.firstName, Label: 'Voornaam klant' },
        { Value: createdAt, Label: 'Datum' }
    ]
);
