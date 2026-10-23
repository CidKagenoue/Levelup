import cds from '@sap/cds'

export class orderService extends cds.ApplicationService {
  init() {

    const { Games, Orders, OrderItems } = cds.entities('orderService')

    // ---------- Order aanmaken: validatie + prijsbepaling ----------
    this.before('CREATE', Orders, async (req) => {
      const { items } = req.data
      if (!items?.length)
        return req.reject(400, 'Een order heeft minstens één orderregel nodig.', 'items')

      const ids = items.map(i => i.game_ID)
      const games = await SELECT.from(Games)
        .columns('ID', 'title', 'price', 'stock')
        .where({ ID: { in: ids } })

      let total = 0
      for (const [i, item] of items.entries()) {
        const game = games.find(g => g.ID === item.game_ID)
        if (!game) {
          req.error(400, 'Game bestaat niet.', `items/${i}/game_ID`)
          continue
        }
        if (!(item.quantity > 0)) {
          req.error(400, `Aantal voor "${game.title}" moet > 0 zijn.`, `items/${i}/quantity`)
          continue
        }
        if (item.quantity > game.stock) {
          req.error(409, `Onvoldoende voorraad voor "${game.title}".`, `items/${i}/quantity`)
          continue
        }

        item.unitPrice = game.price // de server bepaalt de prijs
        total += game.price * item.quantity
      }

      req.data.totalAmount = total // totaalbedrag opslaan
    })

    // ---------- Order aangemaakt: voorraad verlagen ----------
    this.after('CREATE', Orders, async (_, req) => {
      for (const item of req.data.items)
        await UPDATE(Games, item.game_ID).with({
          stock: { '-=': item.quantity }
        })
    })

    // ---------- Bound action: order annuleren ----------
    this.on('cancel', Orders, async (req) => {
      const key = req.params[0]

      const order = await SELECT.one.from(Orders, key)
      if (!order)
        return req.reject(404, 'Order niet gevonden.')

      if (order.status === 'CANCELLED')
        return req.reject(409, 'Order is al geannuleerd.')
      if (order.status === 'PAID')
        return req.reject(409, 'Een betaalde order kan niet geannuleerd worden.')

      // voorraad van elke orderregel terugzetten
      const items = await SELECT.from(OrderItems).where({ up__ID: order.ID })
      for (const item of items)
        await UPDATE(Games, item.game_ID).with({
          stock: { '+=': item.quantity }
        })

      await UPDATE(Orders, order.ID).with({ status: 'CANCELLED' })

      return SELECT.one.from(Orders, order.ID)
    })

    return super.init()
  }
}