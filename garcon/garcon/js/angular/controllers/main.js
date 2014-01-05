function AdminCtrl($scope, $http) {

    //$scope.tables = [{ "id": 1, "restaurantid": 1, "beaconid": "QRGJ-J4HRE" }, { "id": 2, "restaurantid": 1, "beaconid": "TRKY-E5V54" }];
    $http.get('http://lizzard.selfip.com/api/Table/GetTablesForRestaurant?resid=1').success(function (data) {
        $scope.tables = data;
        $('.table-chooser').show();
    });

    //$scope.bill = { "id": 1, "tableid": 1, "paid": false, "checkedin": "2014-01-05T05:04:42.827", "checkedout": null, "items": [{ "id": 4, "billid": 1, "item": { "id": 1, "description": "N9NE ROCK SHRIMP", "price": 19.00 }, "seatnum": 1 }, { "id": 5, "billid": 2, "item": { "id": 2, "description": "LOBSTER POT STICKERS", "price": 19.00 }, "seatnum": 1 }, { "id": 6, "billid": 6, "item": { "id": 6, "description": "22oz. PRIME BONE-\u001fIN RIBEYE", "price": 62.00 }, "seatnum": 1 }], "total": 100.00 };
    $http.get('http://lizzard.selfip.com/api/Table/GetBill?billid=1').success(function (data) {
        $scope.bill = data;
    });

    $http.get('http://lizzard.selfip.com/api/Table/GetMenuForRestaurant?resid=1').success(function (data) {
        $scope.menuitems = data;
    });
    
    //$scope.menuitems =
    //    [{ "id": 1, "description": "N9NE ROCK SHRIMP", "price": 19 },
    //    { "id": 2, "description": "LOBSTER POT STICKERS", "price": 19 },
    //    { "id": 3, "description": "STUFFED ‘SHROOMS", "price": 19 },
    //    { "id": 4, "description": "OSETRA CAVIAR", "price": 145 },
    //    { "id": 5, "description": "48oz. PRIME RIBEYE TOMAHAWK FOR TWO", "price": 145 },
    //    { "id": 6, "description": "22oz. PRIME BONE-\u001fIN RIBEYE", "price": 62 },
    //    { "id": 7, "description": "LOBSTER THERMIDOR", "price": 62 }];

    $scope.selectTable = function () {
        $(".table-chooser").hide();
        $(".menugrid").show();
    };

    $scope.addItemToBill = function (item) {
        billitem = {"billid": 1, "item": item, seatnum: 1};
        $scope.bill.items.push(billitem);
        $scope.bill.total += item.price;
        params = 'billid=1&itemid=' + item.id;
        console.log(params);
        $http.post('http://lizzard.selfip.com/api/Table/AddItemToBill?' + params, null).success(function (data) {
            console.log("added item");
        });
    };

    $scope.goBack = function () {
        $(".table-chooser").show();
        $(".menugrid").hide();
    };
}