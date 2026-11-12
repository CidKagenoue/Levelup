import ControllerExtension from "sap/ui/core/mvc/ControllerExtension";
import UIComponent from "sap/ui/core/UIComponent";

export default class GamesListExtension extends ControllerExtension {
    public onMyOrders(): void {
        const component = this.getView().getController().getOwnerComponent() as UIComponent | undefined;
        component?.getRouter().navTo("OrderList");
    }
}
