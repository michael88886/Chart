//
//  ViewController.swift
//  Chart
//
//  Created by mk mk on 22/7/19.
//  Copyright © 2019 MC2. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
	
	lazy var barchartView: BarChartView = {
		let chartView = BarChartView()
		
		// - View setting
		// Background
//		chartView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
		// Disable legend
		chartView.legend.enabled = false
		// Disabel pinch zoom
		chartView.pinchZoomEnabled = false
		// No bar shadow
		chartView.drawBarShadowEnabled = false
		// No bar border
		chartView.drawBordersEnabled = false
		// No grid background
		chartView.drawGridBackgroundEnabled = false
		
		// - View port
		// Max zoom level
		chartView.viewPortHandler.setMaximumScaleX(1.5)
		
		chartView.minOffset = 0
		
		// - X axis
		// Line width
		chartView.xAxis.axisLineWidth = 1
		// Line color
		chartView.xAxis.axisLineColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		// Grid color
		chartView.xAxis.gridColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.3)
		// Text label color
		chartView.xAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		// Label position
		chartView.xAxis.labelPosition = .bottom
		// Label formatter
		chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
		// Avoid label duplicating 
		chartView.xAxis.granularityEnabled = true
		// Gap between labels (to avoid duplicate)
		chartView.xAxis.granularity = 1

		// - Y axis
		// Line width
		chartView.leftAxis.axisLineWidth = 1.0
		// Line color
		chartView.leftAxis.axisLineColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		// Grid color
		chartView.leftAxis.gridColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.3)
		// Text label color
		chartView.leftAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		// No right Y axis
		chartView.rightAxis.enabled = false
		// Y axis minimum value
		chartView.leftAxis.axisMinimum = 0
		// Disable Y scale (zoom)
		chartView.scaleYEnabled = false
		
		return chartView
	}() 
	
	lazy var scoreLabel: UILabel = {
		let lb = UILabel()
//		lb.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
		lb.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		lb.text = "Score"
		lb.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
		return lb
	}()
	
	lazy var timeLabel: UILabel = {
		let lb = UILabel()
		lb.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		lb.text = "Time"
		return lb
	}()
	
	var months = ["Jan", "Feb", "Mar", "Apr", 
				  "May", "Jun", "Jul", "Aug", 
				  "Sep", "Oct", "Nov", "Dec"]

	let data = [23.0, 44.3, 45.1, 12.0, 
				98.3, 76.5, 67.3, 27.6, 
				58.3, 77.2, 15.7, 2.9]
	
	override func loadView() {
		super.loadView()
		
		view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
		
		view.addSubview(scoreLabel)
		scoreLabel.translatesAutoresizingMaskIntoConstraints = false
		scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		
		view.addSubview(barchartView)
		barchartView.translatesAutoresizingMaskIntoConstraints = false
		barchartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		barchartView.leftAnchor.constraint(equalTo: scoreLabel.rightAnchor, constant:  -10).isActive = true
		barchartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
		barchartView.heightAnchor.constraint(equalTo: barchartView.widthAnchor).isActive = true
		
		view.addSubview(timeLabel)
		timeLabel.translatesAutoresizingMaskIntoConstraints = false
		timeLabel.topAnchor.constraint(equalTo: barchartView.bottomAnchor).isActive = true
		timeLabel.centerXAnchor.constraint(equalTo: barchartView.centerXAnchor).isActive = true
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setData(data: months, values: data)		
		barchartView.zoomToCenter(scaleX: 1.5, scaleY: 0)
		barchartView.animate(yAxisDuration: 0.8)
	}

	
	
	func setData(data: [String], values: [Double]) {
		barchartView.noDataText = "No data"
		
		var dataEntries = [BarChartDataEntry]()
		
		for i in 0..<data.count {
			let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
			dataEntries.append(dataEntry)
		}
		
		let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
		chartDataSet.highlightEnabled = false
		// Bar color
		chartDataSet.colors = [#colorLiteral(red: 0.8352941176, green: 0.5647058824, blue: 0.7450980392, alpha: 1)]
		// Bar text color
		chartDataSet.valueColors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
		let chartData = BarChartData(dataSet: chartDataSet)
		barchartView.data = chartData
	}

}
