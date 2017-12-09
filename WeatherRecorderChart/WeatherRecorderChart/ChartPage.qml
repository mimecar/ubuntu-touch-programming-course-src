import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components.Pickers 1.3

/* Thanks to: https://github.com/jwintz/qchart.js for QML bindings for Charts.js */
import "QChart.js" as Charts

/* replace the 'incomplete' QML API U1db with the low-level QtQuick API */
import QtQuick.LocalStorage 2.0

/* Import our javascrit files */
import "ChartUtils.js" as ChartUtils
import "DateUtils.js"  as DateUtils


/*
  NEW: page: added for chapter about "QML and charts"
  Page that display a monthly chart temperature chart and his legend
*/
Page {
     id: chartPage
     visible: false

     /* default is today, after is updated when the user chose a date with the TimePicker */
     property string targetDate : Qt.formatDateTime(new Date(), "yyyy-MM-dd");

     header: PageHeader {
        title: i18n.tr("Analytic page")
     }

     Column{
        id: chartPageMainColumn
        spacing: units.gu(2)
        anchors.fill: parent

        /* transparent placeholder: to place the content under the header */
        Rectangle {
            color: "transparent"
            width: parent.width
            height: units.gu(6)
        }

        Row{
            id: monthSelectorRow
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:units.gu(2)

            /* Create a PopOver containing a DatePicker */
            Component {
                id: popoverTargetMonthPicker
                Popover {
                    id: popoverDatePicker

                    DatePicker {
                        id: timePicker
                        mode: "Months|Years"
                        minimum: {
                            var time = new Date()
                            time.setFullYear('2000')
                            return time
                        }
                        /* when Datepicker is closed, is updated the date shown in the button */
                        Component.onDestruction: {
                            targetMonthSelectorButton.text = Qt.formatDateTime(timePicker.date, "MMMM yyyy");
                            chartPage.targetDate = Qt.formatDateTime(timePicker.date, "yyyy-MM-dd");
                        }
                    }
                }
            }

            Label{
                id: targetMonthLabel
                anchors.verticalCenter: targetMonthSelectorButton.verticalCenter
                text: i18n.tr("Month:")
            }

            /* open the popOver component with DatePicker */
            Button {
                id: targetMonthSelectorButton
                width: units.gu(20)
                text: Qt.formatDateTime(new Date(), "MMMM yyyy")
                onClicked: {
                    PopupUtils.open(popoverTargetMonthPicker, targetMonthSelectorButton)
                }
            }

            Button {
                id: showChartButton
                width: units.gu(14)
                text: i18n.tr("Show Chart")
                onClicked: {
                    /* extract the year, month, day from the variable 'targetDate' tha contains a value like yyyy-mm-dd */
                    var dateParts = chartPage.targetDate.split("-");

                    /* build a JS Date Object using string tokens (month is 0-based) */
                    var date = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);

                    /* calculates first and last day of the month */
                    var firstDayMonth = new Date( date.getFullYear(),date.getMonth(), 1);
                    var lastDayMonth = new Date( date.getFullYear(), date.getMonth() + 1, 0);

                    /* set the data-set at the chart and make visible the chart and legend */
                    temperatureChart.chartData = ChartUtils.getChartData(firstDayMonth,lastDayMonth);

                    temperatureChartContainer.visible = true;                  
                }
            }
        }

        //---------------- Chart and Legend ---------------------
        Grid {
            id: chartAndLegendGridContainer
            visible: true
            columns:2
            columnSpacing: units.gu(1)
            width: parent.width;
            height: parent.height;

            Rectangle {
                id: temperatureChartContainer
                visible: false
                width: parent.width - chartLegendContainer.width;
                height: parent.height - units.gu(20);

                /* The monthly temperature chart */
                QChart{
                    id: temperatureChart;
                    width: parent.width
                    height: parent.height;
                    chartAnimated: false;
                    /* for all the options see: QChart.js */
                    chartOptions: {"barStrokeWidth": 0};
                    /* chartData: set when the user press 'Show Chart' button */
                    chartType: Charts.ChartType.BAR;
                }
            }

            Rectangle {
                id: chartLegendContainer
                visible: true
                width:  units.gu(18);
                height: parent.height

                /* model for the chart legend */
                ListModel {
                    id: customRangeChartListModel
                }

                /* ListView that display the values in the legend */
                UbuntuListView {
                    id:chartLegendListView
                    anchors.fill: parent

                    /* disable the dragging of the model list elements */
                    boundsBehavior: Flickable.StopAtBounds
                    model: customRangeChartListModel
                    delegate:
                         /* ‘delegate’ is the component that define the layout used to display the value from the ListModel */
                        Component{
                            id: customReportChartLegend
                            Rectangle {
                                id: wrapper
                                height: legendEntry.height
                                border.color: UbuntuColors.graphite
                                border.width:units.gu(0.5)

                                Label {
                                    id: legendEntry
                                     /* ‘key’ and ‘temp’ are the key used to store date and temperature values in the ListModel */
                                    text: date+" :  "+temp
                                    fontSize: Label.XSmall
                                }
                        }
                    }                   
                }

                Scrollbar {
                    flickableItem: chartLegendListView
                    align: Qt.AlignTrailing
                }
            }
        }
    }

}
