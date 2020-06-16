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


    func makeUIView(context: Context) -> UIView {

        var m_view: NChartView!

        // initialize view
        m_view = NChartView()

        // attach liscense key
        m_view.chart.licenseKey = ""

        // add some margin to the borders
        m_view.chart.cartesianSystem.margin = NChartMarginMake(10.0,10.0,10.0,20.0)

        // turn on anti-aliasing for better visual display
        m_view.chart.shouldAntialias = true

        // create a series to be displayed. Give it a brush to color the points
        let series = NChartColumnSeries()
        series.brush = NChartSolidColorBrush(color: UIColor(red: 0.0, green: 0.7, blue: 0.4, alpha: 1.0))

        // assign a data source to the series
        // TODO: Unable to add NChartSeriesDataSource Protocol to struct
//        series.dataSource = self
        m_view.chart.addSeries(series)

        // update the chart to display data.
        // call this method any time data was changed
        m_view.chart.updateData()

        return m_view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    // generate random data points
    func seriesDataSourcePoints(for series: NChartSeries!) -> [Any]! {
        print("generating values")
        // create an array of points with random data
        var result = [NChartPoint]()
        for i in 0...10 {
            result.append(NChartPoint(state: NChartPointState(alignedToXWithX: i, y: Double(Int(arc4random() % 100 + 1))), for: series))
        }

        return result
    }

    // name the series data
    func seriesDataSourceName(for series: NChartSeries!) -> String! {
        print("genereating titles called")
        return "My series"
    }

}
