const cds = require("@sap/cds");

class CatalogService extends cds.ApplicationService {
    init() {
        const { Books } = this.entities;
        // Add discount for overstocked books
        this.after("READ", Books, this.grantDiscount);

        //Reduce the stock of ordered books according to the ordered quantity
        this.on("submitOrder", this.reduceStock);

        return super.init();
    }

    grantDiscount(results) {
        for(let b of results) {
            if(b.stock > 200) {
                b.title += ' -- 11% Discount!';
            }
        }
    }

    reduceStock(req) {
       /*  !!! This is only a preliminary, incomplete implementation of the submitOrder action !!!
        !!! These will be used later to complete the implementaiton !!! */
        const { Books } = this.entities;
        const { book, quantity } = req.data;

        if(quantity < 1) {
            return req.error("The quantity must be atleast 1");
        }

        let stock = 10;

        return { stock };
    }
}

module.exports = CatalogService;