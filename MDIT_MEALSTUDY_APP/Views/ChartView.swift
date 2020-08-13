//
//  ChartView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 6/16/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI
import UIKit


struct ChartView: UIViewRepresentable {
    
    @Binding var test: Bool
    @Binding var viewModel: ContentViewModel

    
    // Creates the initial chart
    func makeUIView(context: Context) -> NChartView {

        
        // create a new nchart uiView
        let m_view = NChartView()
        
        // attach liscense key
        /*** THIS KEY WILL EXPIRE JULY 19TH, 2020  ***/
        m_view.chart.licenseKey = "FtfPjf1xOUp1zpX68ljb5nx7ickJlZco5GaaUjrzJxxbCOPhIxW+GLZyRsb9YQ25rwIxc2aOrdhleuwiQhE3InC0V0eBAEFBWwh2ti1+7DmFxLaMzPn5596VzDXVhxLaaseBWhQ45YIYaOa6ePMhFDuuJpgsl7JGdABJZOOIcDDkjoBLZIz9M1ODbhuxGxf9VEqCYzy1AA+/y72EvKWU5XxJQB0okCPBGMiQ8G2In5QgmMrwqRIWGgi7/UodXeyAzD3QduUg6Bu6cmsSLd0NxBJsFr6Y0AdtI9xz50p4+FqudbHky226Msle0TWA3/wKuusZ1N51UpoGqelewR1XJ0MPBgOoqzDaQBUPFql3LpYOVU259/pkl32/muQzVukUZtZumaWHcEX0sUzmAn94oWtmauuyc0NtmIdkdoCIRjgduvGxJo4z/ysUxf66wZyb0TrqC9O7jy3gEldKiUeLWx56Z+RMBBLUd4TIcpYxy0oRpYypaCol4jIhVwo/Q5752FTJ2w5xdjgV0O5UzSafkpWZhgI/sMLtPCnTGMY6ZZxvLNz8ZR+mBY+CgmLHSJ1ZPtW7hH4AxHlCxBIjwb+hZ3dLQH2MbzPdIEETI2od+fjOQ2WAxGxAsvEYv9PBy4IUT3LHwQUc1GBQXfNUEXeCuYNAAf9b6W/1NciCdkxx3S0="
        
        // Remove marks from the axis
        m_view.chart.cartesianSystem.yAxis.removeAllMarks()
        m_view.chart.cartesianSystem.syAxis.removeAllMarks()
        
        // remove the gridlines and borders
        m_view.chart.cartesianSystem.borderVisible = false;
        m_view.chart.cartesianSystem.xAlongY.visible = false;
        m_view.chart.cartesianSystem.syAlongX.visible = false;
        m_view.chart.cartesianSystem.yAlongX.visible = false;
        
        m_view.chart.cartesianSystem.xAxis.hasOffset = true
        
        m_view.chart.shouldBouncePan = false
        
        m_view.chart.zoomMode = NChartZoomMode.none
        
        // Turn on the date time mode of X-Axis.
        m_view.chart.cartesianSystem.xAxis.hasDates = true
        m_view.chart.cartesianSystem.xAxis.shouldBeautifyMinAndMax = false
        m_view.chart.cartesianSystem.yAxis.shouldBeautifyMinAndMax = false
//        m_view.chart.cartesianSystem.syAxis.shouldBeautifyMinAndMax = false
        

        // Style ticks and labels
        m_view.chart.cartesianSystem.xAxis.minTickSpacing = 0.0
        m_view.chart.cartesianSystem.xAxis.maxLabelLength = 50.0
        m_view.chart.cartesianSystem.xAxis.labelsLineBreakMode = NSLineBreakMode.byWordWrapping

        m_view.chart.cartesianSystem.syAxis.labelsVisible = false   // disable right hand Y labels

        m_view.chart.cartesianSystem.xAxis.font = .systemFont(ofSize: 12.0)
        
        // Creat the low and high marker ranges
        let highMark :NChartValueAxisMark = Coordinator.getAxisMark(margin: 0.0, font: 12.0, color: UIColor(red:0.99, green:0.80, blue:0.00, alpha:1.0), value: Double(130), text: nil)
        m_view.chart.cartesianSystem.syAxis.addMark(highMark)

        let lowMark :NChartValueAxisMark = Coordinator.getAxisMark(margin: 0.0, font: 12.0, color: .red, value: Double(70), text: nil)
        m_view.chart.cartesianSystem.syAxis.addMark(lowMark)
        
        let firstxMark :NChartValueAxisMark = Coordinator.getAxisMark(margin: 0.0, font: 12.0, color: .black, value: 0.0, text: nil)
        m_view.chart.cartesianSystem.yAxis.addMark(firstxMark)

        let secondxMark :NChartValueAxisMark = Coordinator.getAxisMark(margin: 0.0, font: 12.0, color: .black, value: 0.5, text: nil)
        m_view.chart.cartesianSystem.yAxis.addMark(secondxMark)

        let thirdxMark :NChartValueAxisMark = Coordinator.getAxisMark(margin: 0.0, font: 12.0, color: .black, value: 1.0, text: nil)
        m_view.chart.cartesianSystem.yAxis.addMark(thirdxMark)

        let fourthxMark :NChartValueAxisMark = Coordinator.getAxisMark(margin: 0.0, font: 12.0, color: .black, value: 1.5, text: nil)
        m_view.chart.cartesianSystem.yAxis.addMark(fourthxMark)
        
        // add some margin to the borders
        m_view.chart.cartesianSystem.margin = NChartMarginMake(10.0,10.0,10.0,20.0)
        
        // *** This is mandatory to provide ticks for X-Axis.
        m_view.chart.cartesianSystem.xAxis.dataSource = context.coordinator
        
        // *** Increase the minimal tick spacing for X-Axis to avoid line breaks in ticks.
        m_view.chart.cartesianSystem.xAxis.minTickSpacing = 60.0
 
        // turn on anti-aliasing for better visual display
        m_view.chart.shouldAntialias = true
        
        // set chart background color
//        m_view.chart.background = NChartSolidColorBrush(color: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
        
        // create a series to be displayed.
        let series = NChartLineSeries()
                        
        // give series color and pattern
        series.brush = NChartSolidColorBrush(color: UIColor.green)
        series.lineDash = NChartLineDash(pattern: [3, 3])
        series.lineThickness = 2
    
        series.brush = NChartSolidColorBrush(color: UIColor(red:0.00, green:0.12, blue:0.38, alpha:1.0))
        series.lineThickness = 0
        series.marker = NChartMarker()
        series.marker.shape = NChartMarkerShape.circle
        series.marker.size = 5
        series.marker.brush = NChartSolidColorBrush(color: UIColor(red:0.00, green:0.12, blue:0.38, alpha:1.0))
        series.hostsOnSY = true;
        
        // set series data source
        series.dataSource = context.coordinator
        
        // Create crosshair.
        let lowCs = NChartCrosshair()
        
        // Set color for crosshair's haris.
        lowCs.yHair.setColor(UIColor.red)
        
        // Set thickness for crosshair's hairs.
        lowCs.thickness = 2.0
        
        // Set value for crosshair.
        lowCs.yHair.value = 70
        lowCs.yHair.hostsOnSAxis = true
        lowCs.xHair.visible = false
        lowCs.yHair.isDraggable = false

        m_view.chart.cartesianSystem.add(lowCs)
        
        // Create crosshair.
        let highCs = NChartCrosshair()
        
        // Set color for crosshair's haris.
        highCs.yHair.setColor(UIColor(red:0.99, green:0.80, blue:0.00, alpha:1.0))
        
        // Set thickness for crosshair's hairs.
        highCs.thickness = 2.0
        
        // Set value for crosshair.
        highCs.yHair.value = 130
        highCs.yHair.hostsOnSAxis = true
        highCs.xHair.visible = false
        highCs.yHair.isDraggable = false
        
        m_view.chart.cartesianSystem.add(highCs)
        
        // assign a data source to the series
        m_view.chart.removeAllSeries()
        m_view.chart.addSeries(series)
        
        // Activate auto scroll and auto toggle of scroll by pan.
        m_view.chart.shouldAutoScroll = true
        m_view.chart.shouldToggleAutoScrollByPan = true
        
        // Create label that is shown when auto scroll toggles.
        let lbl = NChartAutoScrollLabel()
        lbl.background = NChartSolidColorBrush(color: UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8))
        lbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        lbl.textColor = UIColor.white
        lbl.padding = NChartMarginMake(20.0, 20.0, 5.0, 10.0)
        lbl.onText = "Autoscroll ON"
        lbl.offText = "Autoscroll OFF"
        m_view.chart.autoScrollLabel = lbl
        
        // Enable auto-zoom of the Y-Axis.
        m_view.chart.cartesianSystem.shouldAutoZoom = false
        m_view.chart.cartesianSystem.autoZoomAxes = NChartAutoZoomAxes.bothAxes
        /**This can also be NChartAutoZoomAxes.SecondaryAxis, in case series are hosted on the secondary axis. **/
        
        // Disable unwanted interactive vertical panning and zooming not to conflict with automatic ones.
        m_view.chart.userInteractionMode = (m_view.chart.userInteractionMode) ^ (NChartUserInteraction.proportionalZoom.rawValue | NChartUserInteraction.verticalZoom.rawValue | NChartUserInteraction.verticalMove.rawValue);
        
        // Disable ticks on axis
        m_view.chart.cartesianSystem.xAxis.minorTicks.visible = false;
        m_view.chart.cartesianSystem.xAxis.majorTicks.visible = false;
        m_view.chart.cartesianSystem.yAxis.minorTicks.visible = false;
        m_view.chart.cartesianSystem.yAxis.majorTicks.visible = false;
        m_view.chart.cartesianSystem.syAxis.minorTicks.visible = false;
        m_view.chart.cartesianSystem.syAxis.majorTicks.visible = false;
        
        // update the chart to display data. call this method any time data was changed
        m_view.chart.updateData()
        m_view.chart.maxZoom = 1000
        
        return m_view
    }
 
    // Called when the UI should be changed
    func updateUIView(_ uiView: NChartView, context: Context) {
        
        // extends the visible chart
        uiView.chart.extendData()
    }
    
    // Connects a Coordinator class to the UIView Representable
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    
    // MARK: Coordinator Class

    // Coordinator class needed for controlling the view
    class Coordinator: NSObject, NChartSeriesDataSource, NChartValueAxisDataSource, UINavigationControllerDelegate, ObservableObject {
    
        @State var viewModel = ContentViewModel()
        
        var parent: ChartView
        
        init(_ parent: ChartView ) {
            self.parent = parent
        }
            
        var m_count: Int = 0        // used to track index in chart
        let valueArray = [60, 70, 75, 75, 80, 90, 110, 135, 140, 120, 100, 80, 80]     // test array of input values for chart
  
        var counter = 0                     // tracks current position in value array
        
//        var currentTimestamp: String = ""   // stores generated cgm value (y-axis value)
//        var currentValue: String = ""       // stores generated cgm date (x-axis value)
        
        
        
        
        // MARK: Utility Functions
      
        static func getMarkerBrush(color : UIColor) -> NChartMarker{
            let marker = NChartMarker()
            marker.shape = NChartMarkerShape.circle
            marker.size = 5
            marker.brush = NChartSolidColorBrush(color: color)
            return marker

        }
        
        
        // create marks for the axis
        static func getAxisMark(margin: Float, font: Float, color: UIColor, value: Double, text: String?) -> NChartValueAxisMark{
            
            let mark :NChartValueAxisMark = NChartValueAxisMark()
            mark.margin.right = margin
            mark.textColor = color
            mark.value = value
            
            if(text == nil){
                mark.text = "\(value)";
            }else{
                mark.text = text
            }
            mark.tick.visible = false
            mark.font = .systemFont(ofSize: CGFloat(font))
            
            return mark
            
        }
        
         static func hexStringToUIColor (hex:String) -> UIColor {
                var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
                if (cString.hasPrefix("#")) {
                    cString.remove(at: cString.startIndex)
                }
                
                if ((cString.count) != 6) {
                    return UIColor.gray
                }
                
                var rgbValue:UInt64 = 0
                Scanner(string: cString).scanHexInt64(&rgbValue)
                
                return UIColor(
                    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                    alpha: CGFloat(1.0)
                )
            }
        
        
        
        
        // MARK: NChartSeriesDataSource
        
        // Used to set initial values for the x an y axis
        func seriesDataSourcePoints(for series: NChartSeries!) -> [Any]! {
    
            var result = [NChartPoint]()    // empty array for the initial points
            var point: NChartPoint
            
            m_count = 0                     // set index to zero

            // TODO: Grab values from previous 12 hours

            
            //populate the chart with N values
            for _ in 0...10 {
                point = setInitialPoints(series: series, index: m_count)
                result.append(point) // append random value to current index
                m_count += 1    // increment index
            }
            
            return result // returns array of points
        
        }
        
    
        
        // Set name for the data series
        func seriesDataSourceName(for series: NChartSeries!) -> String! {
           return "Glucose Level (mg/dL)"
        }
        
        
        func newState(_ index: Int) -> NChartPointState! {
                    
            let m_value = Double(parent.viewModel.currentValue)
            
            return NChartPointState(alignedToXWithX: index, y: m_value ?? 00)

        }
        
        func setPoint(series: NChartSeries!)->NChartPoint{
            var chartPoint: NChartPoint
            chartPoint = NChartPoint(state: newState(m_count), for: series)!
            
            if(chartPoint.currentState.doubleY != 0.0 && chartPoint.currentState.doubleY <= Double(70)){
                chartPoint.currentState.marker = ChartView.Coordinator.getMarkerBrush(color: UIColor.red)
            }else if(chartPoint.currentState.doubleY != 0.0 && chartPoint.currentState.doubleY >= Double(130)){
                chartPoint.currentState.marker = ChartView.Coordinator.getMarkerBrush(color: UIColor(red:0.99, green:0.80, blue:0.00, alpha:1.0))
            }
            
            return chartPoint
        }
        
        func setInitialPoints(series: NChartSeries!, index: Int)->NChartPoint{
            var chartPoint: NChartPoint
            chartPoint = NChartPoint(state: randomState(m_count), for: series)!
            
            if(chartPoint.currentState.doubleY != 0.0 && chartPoint.currentState.doubleY <= Double(70)){
                chartPoint.currentState.marker = ChartView.Coordinator.getMarkerBrush(color: UIColor.red)
            }else if(chartPoint.currentState.doubleY != 0.0 && chartPoint.currentState.doubleY >= Double(130)){
                chartPoint.currentState.marker = ChartView.Coordinator.getMarkerBrush(color: UIColor(red:0.99, green:0.80, blue:0.00, alpha:1.0))
            }
            
            return chartPoint
        }
        
        // generate extra points for extending the chart
        func seriesDataSourceExtraPoints(for series: NChartSeries!) -> [Any]! {
            
            var result = [NChartPoint]()
       
            let point = setPoint(series: series)
            result.append(point)
            m_count += 1
            
            return result as [AnyObject]
        }
        
//        func displayReferenceLines(series: NChartSeries, glucoseThreshold: GlucoseThresholdModel){
//
//            // Create crosshair.
//            let lowCs = NChartCrosshair()
//
//            // Set color for crosshair's haris.
//            lowCs.yHair.setColor(UIColor.red)
//
//            // Set thickness for crosshair's hairs.
//            lowCs.thickness = 2.0
//
//            // Set value for crosshair.
//            lowCs.yHair.value = Double(glucoseThreshold.low)!
//            lowCs.yHair.hostsOnSAxis = true
//            lowCs.xHair.visible = false
//            lowCs.yHair.isDraggable = false
//
//            series.chart.cartesianSystem.add(lowCs)
//
//            // Create crosshair.
//            let highCs = NChartCrosshair()
//
//            // Set color for crosshair's haris.
//            highCs.yHair.setColor(UIColor(red:0.99, green:0.80, blue:0.00, alpha:1.0))
//
//            // Set thickness for crosshair's hairs.
//            highCs.thickness = 2.0
//
//            // Set value for crosshair.
//            highCs.yHair.value = Double(glucoseThreshold.high)!
//            highCs.yHair.hostsOnSAxis = true
//            highCs.xHair.visible = false
//            highCs.yHair.isDraggable = false
//
//            series.chart.cartesianSystem.add(highCs)
//
//        }
        
        
        // MARK: NChartValueAxisDataSource
        
        // Create initial ticks for X-Axis. *** THIS IS REQUIRED TO LABEL INITIAL TICKS ON X-AXIS ***
        func valueAxisDataSourceTicks(for axis: NChartValueAxis!) -> [Any]! {
            
            if axis.kind != NChartValueAxisKind.X {
                return nil
            }
            
            var result: [String] = []
            let array = Array(0...m_count - 1)
            for i in array {
                result.append(dateForIndex(i))
            }
            return result as [AnyObject]
        }

        // Create ADITIONAL ticks for X-Axis. *** THIS IS REQUIRED TO LABEL EXTRA TICKS ON X-AXIS ***
        func valueAxisDataSourceExtraTicks(for axis: NChartValueAxis!) -> [Any]! {
            
            if axis.kind != NChartValueAxisKind.X {
                return nil
            }
            let date = ContentViewModel()
//            return [date.currentTime as AnyObject]
            return [dateForIndex(m_count) as AnyObject]
        }
        
        
        
        // MARK: Utility Functions
        
        // Generate date / time for x-axis
        func dateForIndex(_ index: Int) -> String! {
            
            // TODO: Modify this code to display the data from the past X hours
            var dayComponent = DateComponents()
            dayComponent.day = index
            let calendar = Calendar.current
            let date = (calendar as NSCalendar).date(byAdding: dayComponent, to: Date(), options: NSCalendar.Options())

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            
            return dateFormatter.string(from: date!)
            
        }
        
        // get a sudo-randomly generated cgm value
        func randomState(_ index: Int) -> NChartPointState! {
            
            if (counter > valueArray.count - 1) {  // reset index counter at end of array
                counter = 0
            }

            let value = valueArray[counter]     // retrieve value from array
            counter += 1                        // increment index
            
            return NChartPointState(alignedToXWithX: index, y: Double(value))
        }
        
        
        
    } // end class coordinator
} // end struct
