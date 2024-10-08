/*eslint-disable*/

var fields = [
  {
      "fieldName": "icon",
      "dataType": "number"
  },
  {
      "fieldName": "구분",
      "dataType": "text"
  },
  {
      "fieldName": "산업1",
      "dataType": "number"
  },
  {
      "fieldName": "산업2",
      "dataType": "number"
  },
  { 
      "fieldName": "산업3",
      "dataType": "number"
  },
  {
      "fieldName": "산업4",
      "dataType": "number"
  },
  {
      "fieldName": "산업5",
      "dataType": "number"
  },
  {
      "fieldName": "산업6",
      "dataType": "number"
  },
  {
      "fieldName": "산업7",
      "dataType": "number"
  }
]

var columns = [
  {
      "name": "구분",
      "fieldName": "구분",
      "type": "data",
      "width": "150",
      "header": {
          "text": "구분"
      }
  },
  {
      "name": "산업1",
      "fieldName": "산업1",
      "type": "data",
      "width": "80",
      "numberFormat": "#,##0",
      "header": {
          "text": "농림어업"
      }
  },
  {
      "name": "산업2",
      "fieldName": "산업2",
      "type": "data",
      "width": "75",
      "numberFormat": "#,##0",
      "header": {
          "text": "광업"
      }
  },
  {
      "name": "산업3",
      "fieldName": "산업3",
      "type": "data",
      "width": "75",
      "numberFormat": "#,##0",
      "header": {
          "text": "제조업"
      }
  },
  {
      "name": "산업4",
      "fieldName": "산업4",
      "type": "data",
      "width": "80",
      "numberFormat": "#,##0",
      "header": {
          "text": "건설업"
      }
  },
  {
      "name": "산업5",
      "fieldName": "산업5",
      "type": "data",
      "width": "130",
      "numberFormat": "#,##0",
      "header": {
          "text": "도소매, 소비자용품"
      }
  },
  {
      "name": "산업6",
      "fieldName": "산업6",
      "type": "data",
      "width": "90",
      "numberFormat": "#,##0",
      "header": {
          "text": "음식숙박업"
      }
  },
  {
      "name": "산업7",
      "fieldName": "산업7",
      "type": "data",
      "width": "120",
      "numberFormat": "#,##0",
      "header": {
          "text": "운수,창고 통신업"
      }
  }
];

var httpRequest;

function setProvider(filename) {
  httpRequest = new XMLHttpRequest();
  httpRequest.onreadystatechange = loadData;
  httpRequest.open("GET", "/data/" + filename);
  httpRequest.send();
}

function loadData() {
  if (httpRequest.readyState === XMLHttpRequest.DONE) {
    if (httpRequest.status === 200) {
      var data = JSON.parse(httpRequest.responseText);
      treeProvider.setObjectRows(data, "rows", "", "icon");
      treeView.refresh();
      treeView.expandAll();
      treeView.setFocus();
    }
  }
}


const layout1 = [
  "구분",
  {
    name: "companyGroup",
    direction: "horizontal",
    hideChildHeaders: true,
    items: [
      "산업1",
      "산업2"
    ],
    header: {
      text: "산업12",
    }
  }, 
  "산업3", 
  "산업4", 
  "산업5",
  "산업6",
  "산업7"
];

var treeProvider, treeView;

function createGrid(container) {
  treeProvider = new RealGrid.LocalTreeDataProvider();
  treeView = new RealGrid.TreeView(container);

  treeView.setDataSource(treeProvider);
  treeProvider.setFields(fields);
  treeView.setColumns(columns);
  
  //treeProvider.softDeleting = false;
  treeProvider.softDeleting = true;
  treeProvider.deleteCreated = true;
  treeView.hideDeletedRows = false;

  treeView.displayOptions.emptyMessage = "표시할 데이타가 없습니다.";
  treeView.displayOptions.rowHeight = 36;
  treeView.header.height = 40;
  treeView.footer.height = 40;
  treeView.stateBar.width = 16;
  treeView.editOptions.movable = true;
  
  treeView.treeOptions.iconImagesRoot = "/images/flags/";
  treeView.treeOptions.iconImages = [
                "male.png",
                "female.png",
                "grd_tree_close.png",
                "grd_tree_open.png",
                "br.png",
                "de.png",
                "es.png",
                "fr.png",
                "gb.png",
                "gr.png",
                "hu.png",
                "is.png",
                "kr.png",
                "mx.png",
                "pt.png",
                "us.png",
                "ve.png",
                "br.png",
                "de.png",
                "es.png",
                "fr.png", 
                "gr.png"
        
  ];

  setProvider("./treedata.json");
  treeView.setColumnLayout(layout1);
}

function start() {
  createGrid("realgrid");
  init2(); 
}

window.onload = start;
// domloaded를 대신 써도 됩니다.

window.onunload = function() {
  treeProvider.clearRows();

  treeView.destroy();
  treeProvider.destroy();

  treeView = null;
  treeProvider = null;
}