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

    
    // Creates the initial chart
    func makeUIView(context: Context) -> NChartView {

        
        // create a new nchart uiView
        let m_view = NChartView()
        
        
        // attach liscense key
        /*** THIS KEY WILL EXPIRE JULY 19TH, 2020  ***/
        m_view.chart.licenseKey = "dEH1XucrL/2KZnvW5KnsXa2nsvgvl4qHykTWdqkzeNeSKW3NOo0sCNQg9dlhfGAOPUHm3RYQTIzUu01kRnuHwFtezNxPgSpLabrvgPVhbinpyELNLnw1OdOxFZhp0hung5x97uaGkwY2olg6hhqfam/xTpF0BwAOHwOnlXlUSDkp7zaMY0Wy81dqugCss/j1mdpbG4NQkvqtqQC2lq+axNVTbw8snMZsWfPRKswt2b+Pblnq/+bsfe/2WRRhAvm9+INZ29+g8htkLI6a+XDsZAObzE7n/Z/HmIXkMlDhEuJ3a7Ch4ekT/+ITh4MgWUEeHAME+EOvjJX0JTEFHFfAbfD+jNYK7jVORcGGcdsVDWU5eo7mLl9JaKC50nboGxinXLF/MosecghvsyYQNC6XHjs8m3PlqNQM0Q83l2xEU2/F2Q3fFQxvwYf2LwBAu/hPmC27lmIHUroFNKOJzT8FITvkMeRNLeMb2yK2J9m8DbqGLATiEJcKTPMI50dpWpZwbmNInZpfOwR5nHsNf0/qzajHv1S6xm0Asto5EiSmLWKt8Tv0v2sEjK/p7xbFZdfhgJSgR/5tBghfim1YXggP4HdZr03UXXqiH2TYg5i4TTOyCv7Yv2MHSmTYH8X6dPJvY9c+mzDfaBNbsrM91pCaJVPMqXIFLNuBh/lypWW5U08="
 
        // add some margin to the borders
        m_view.chart.cartesianSystem.margin = NChartMarginMake(10.0,10.0,10.0,20.0)
        
        // *** This is mandatory to provide ticks for X-Axis.
        m_view.chart.cartesianSystem.xAxis.dataSource = context.coordinator
        
        // *** Increase the minimal tick spacing for X-Axis to avoid line breaks in ticks.
        m_view.chart.cartesianSystem.xAxis.minTickSpacing = 60.0
 
        // turn on anti-aliasing for better visual display
        m_view.chart.shouldAntialias = true
 
        // create a series to be displayed.
        let series = NChartLineSeries()
        
        // Give it a brush to color the points
        series.brush = NChartSolidColorBrush(color: UIColor(red: 0.0, green: 0.7, blue: 0.4, alpha: 1.0))
 
        // assign a data source to the series
        m_view.chart.addSeries(series)
        series.dataSource = context.coordinator
        
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
        m_view.chart.cartesianSystem.shouldAutoZoom = true
        m_view.chart.cartesianSystem.autoZoomAxes = NChartAutoZoomAxes.normalAxis
        /**This can also be NChartAutoZoomAxes.SecondaryAxis, in case series are hosted on the secondary axis. **/
        
        // Disable unwanted interactive vertical panning and zooming not to conflict with automatic ones.
        m_view.chart.userInteractionMode = (m_view.chart.userInteractionMode) ^ (NChartUserInteraction.proportionalZoom.rawValue | NChartUserInteraction.verticalZoom.rawValue | NChartUserInteraction.verticalMove.rawValue);
        m_view.chart.zoomMode = NChartZoomMode.directional;
 
        // update the chart to display data.
        // call this method any time data was changed
        m_view.chart.updateData()
        
        return m_view
    }
 
    // Called when the UI should be changed
    func updateUIView(_ uiView: NChartView, context: Context) {
        
        // extends the visible chart
        uiView.chart.extendData()
    }
    
    // Connects a Coordinator class to the UIView Representable
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    
    
    
    // MARK: Coordinator Class

    // Coordinator class needed for controlling the view
    class Coordinator: NSObject, NChartSeriesDataSource, NChartValueAxisDataSource, UINavigationControllerDelegate, ObservableObject {
        
        var m_count: Int = 0        // used to track index in chart
        let valueArray = [2, 4, 6, 8, 6, 4]     // test array of input values for chart
  
        var counter = 0                     // tracks current position in value array
        
        var currentTimestamp: String = ""   // stores generated cgm value (y-axis value)
        var currentValue: String = ""       // stores generated cgm date (x-axis value)
        
        // MARK: Utility Functions
        
        // Generate random value
        func myrand(_ max: Int) -> Double {
            return Double(arc4random_uniform(UInt32(max)))
        }
        
        // Sets the current value to that of the most recent cgm
        func setCurrentValues() {
        }
        
        // MARK: NChartSeriesDataSource
        
        // TODO: Populate Chart with previous Patients Data
        // Used to set initial values for the x an y axis
        func seriesDataSourcePoints(for series: NChartSeries!) -> [Any]! {
    
            var result = [NChartPoint]()    // empty array for the initial points
            m_count = 0                     // set index to zero
            
            //populate the chart with N values
            for _ in 0...10 {
                result.append(NChartPoint(state: randomState(m_count), for: series)) // append random value to current index
                m_count += 1    // increment index
            }
            
            return result // returns array of points
        }
        
        // Set name for the data series
        func seriesDataSourceName(for series: NChartSeries!) -> String! {
           return "Glucose Level (mmol/L)"
        }
        
        // TODO: Get additional points from the generated cgm
        // generate extra points for extending the chart
        func seriesDataSourceExtraPoints(for series: NChartSeries!) -> [Any]! {
            
            let result = [NChartPoint(state: randomState(m_count), for: series)!]
            m_count += 1
            
            return result as [AnyObject]
        }
        
        
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
