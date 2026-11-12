import PageController from "sap/fe/core/PageController";

export default class OrderList extends PageController {
    public onNavBack(): void {
        this.getAppComponent().getRouter().navTo("GamesList");
    }
}
