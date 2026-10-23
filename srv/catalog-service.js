import cds from '@sap/cds'

export class catalogService extends cds.ApplicationService { init() {

  const { Games, Genres, Platforms, GameTags, Tags, Reviews, Customers } = cds.entities('catalogService')

  this.before(['CREATE', 'UPDATE'], Reviews, (req) => {
    const { comment } = req.data

    // bij een UPDATE (PATCH) kan het veld ontbreken: dan valt er niets te controleren
    if (comment === undefined) return

    if (comment === null || comment.trim().length < 10)
      return req.reject(400, 'Commentaar moet minstens 10 tekens hebben.', 'comment')
  })

  this.on('topGames', async (req) => {
  const { limit } = req.data

  if (limit === undefined || limit === null || limit < 1)
    return req.reject(400, 'limit moet minstens 1 zijn.', 'limit')

  return SELECT.from(Reviews)
    .columns(
      'game.ID as ID',
      'game.title as title',
      'round(avg(rating), 2) as avgRating',
      'count(*) as reviews'
    )
    .groupBy('game.ID', 'game.title')
    .orderBy('avgRating desc', 'reviews desc')
    .limit(limit)
})

  return super.init()
}}