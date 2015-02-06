CopiedCode

Demo V1

//// General Declarations
let context = UIGraphicsGetCurrentContext()


//// Gradient Declarations
let backGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.lightGrayColor().CGColor, UIColor.darkGrayColor().CGColor], [0, 1])

//// Rectangle Drawing
let rectanglePath = UIBezierPath(roundedRect: CGRectMake(10, 10, 300, 180), cornerRadius: 11)
CGContextSaveGState(context)
rectanglePath.addClip()
CGContextDrawLinearGradient(context, backGradient, CGPointMake(160, 10), CGPointMake(160, 190), 0)
CGContextRestoreGState(context)

Demo V2

   override func drawRect(rect: CGRect) {
   drawGraph(frame: rect)
  }
  
func drawGraph(#frame: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()


    //// Gradient Declarations
    let backGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.lightGrayColor().CGColor, UIColor.darkGrayColor().CGColor], [0, 1])

    //// Rectangle Drawing
     let rectangleRect = CGRectMake(frame.minX + floor(frame.width * 0.03125 + 0.5), frame.minY + floor(frame.height * 0.05000 + 0.5), floor(frame.width * 0.96875 + 0.5) - floor(frame.width * 0.03125 + 0.5), floor(frame.height * 0.95000 + 0.5) - floor(frame.height * 0.05000 + 0.5))
    let rectanglePath = UIBezierPath(roundedRect: rectangleRect, cornerRadius: 11)
    CGContextSaveGState(context)
    rectanglePath.addClip()
    CGContextDrawLinearGradient(context, backGradient,
        CGPointMake(rectangleRect.midX, rectangleRect.minY),
        CGPointMake(rectangleRect.midX, rectangleRect.maxY),
        0)
    CGContextRestoreGState(context)
}

Lab Code V1

func drawGraph(#frame: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()

    //// Color Declarations
    let gridLineColor = UIColor(red: 0.919, green: 0.927, blue: 0.903, alpha: 1.000)

    //// Gradient Declarations
    let backGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.lightGrayColor().CGColor, UIColor.darkGrayColor().CGColor], [0, 1])

    //// Rectangle Drawing
    let rectangleRect = CGRectMake(frame.minX + floor(frame.width * 0.03125 + 0.5), frame.minY + floor(frame.height * 0.05000 + 0.5), floor(frame.width * 0.96875 + 0.5) - floor(frame.width * 0.03125 + 0.5), floor(frame.height * 0.95000 + 0.5) - floor(frame.height * 0.05000 + 0.5))
    let rectanglePath = UIBezierPath(roundedRect: rectangleRect, cornerRadius: 11)
    CGContextSaveGState(context)
    rectanglePath.addClip()
    CGContextDrawLinearGradient(context, backGradient,
        CGPointMake(rectangleRect.midX, rectangleRect.minY),
        CGPointMake(rectangleRect.midX, rectangleRect.maxY),
        0)
    CGContextRestoreGState(context)


    //// topGridLine Drawing
    var topGridLinePath = UIBezierPath()
    topGridLinePath.moveToPoint(CGPointMake(frame.minX + 0.08906 * frame.width, frame.minY + 0.14250 * frame.height))
    topGridLinePath.addCurveToPoint(CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.14250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89219 * frame.width, frame.minY + 0.13750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.14250 * frame.height))
    gridLineColor.setStroke()
    topGridLinePath.lineWidth = 1
    topGridLinePath.stroke()


    //// midGridLine Drawing
    var midGridLinePath = UIBezierPath()
    midGridLinePath.moveToPoint(CGPointMake(frame.minX + 0.08906 * frame.width, frame.minY + 0.50250 * frame.height))
    midGridLinePath.addCurveToPoint(CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.50250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89219 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.50250 * frame.height))
    gridLineColor.setStroke()
    midGridLinePath.lineWidth = 1
    CGContextSaveGState(context)
    CGContextSetLineDash(context, 0, [4, 7], 2)
    midGridLinePath.stroke()
    CGContextRestoreGState(context)


    //// bottomGridLine Drawing
    var bottomGridLinePath = UIBezierPath()
    bottomGridLinePath.moveToPoint(CGPointMake(frame.minX + 0.08906 * frame.width, frame.minY + 0.84250 * frame.height))
    bottomGridLinePath.addCurveToPoint(CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.84250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89219 * frame.width, frame.minY + 0.83750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.84250 * frame.height))
    gridLineColor.setStroke()
    bottomGridLinePath.lineWidth = 1
    bottomGridLinePath.stroke()


    //// lineGraphRect Drawing
    let lineGraphRectPath = UIBezierPath(rect: CGRectMake(frame.minX + floor(frame.width * 0.09062 + 0.5), frame.minY + floor(frame.height * 0.20000 + 0.5), floor(frame.width * 0.89844) - floor(frame.width * 0.09062 + 0.5) + 0.5, floor(frame.height * 0.78000 + 0.5) - floor(frame.height * 0.20000 + 0.5)))
    UIColor.whiteColor().setStroke()
    lineGraphRectPath.lineWidth = 1
    lineGraphRectPath.stroke()
}
