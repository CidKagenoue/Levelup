using AdminService as service from '../../srv/admin-service';

annotate service.GameLeaderboard with @(
    UI.LineItem: [
        { Value: title, Label: 'Titel' },
        {
            $Type: 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#rating',
            Label: 'Gemiddelde rating'
        },
        { Value: reviewCount, Label: 'Aantal reviews' }
    ],
    UI.DataPoint #rating: {
        Value: avgRating,
        Visualization: #Rating,
        TargetValue: 5
    },
    UI.PresentationVariant: {
        SortOrder: [
            { Property: avgRating, Descending: true },
            { Property: reviewCount, Descending: true }
        ],
        Visualizations: [ '@UI.LineItem' ]
    }
);
