## 10b) Designing your widget's interface
1. Open **MainInterface.storyboard** located in the "Counting Down" group
2. Delete the Hello World label
3. Select **Today View Controller** in the Document Outline
4. In the Utilities pane switch to the Size Inspector
5. Set the Height property to **150**
6. Drag a **Table View** into the scene (not a Table View Controller)
7. With the Table View selected, switch to the Attributes Inspector and set **Separator to None**
8. With the table view selected, use Auto-Layout to **pin all sides to 0** and verify that "Constrains to Margins" is turned off and choose **Items of new Constraints** for Update Frames
9. With the Table View selected switch to the Size Inspector and set **Row Height to 50**
10. Drag a **Table View Cell** into your table view
11. Drag an **Image View** into your table view cell
12. With the image view selected, use Auto-Layout to **pin all sides to 0** and verify that "Constrains to Margins" is turned off and choose **Items of new Constraints** for Update Frames
13. With the image view still selected, from the Attributes Inspector set Mode to **Aspect Fill** and enable **Clip Subviews**
14. Drag a **Visual Effect View with Blur** into your table view cell to sit above the image view
15. With the effect view selected, use Auto-Layout to **pin the leading, trailing and bottom to 0**, first verifying that "Constrains to Margins" is turned off.  Also pin the **height to 50** and choose **Items of new Constraints** for Update Frames
16. Drag a second **Visual Effect View with Blur** into your table view cell to be a sub view of the previous. To ensure that it is a sub view it will be best to drag the new one to the **View** within the previous view effect view in the Document Outline
17. With the second effect view selected, use Auto-Layout to **pin all sides to 0** and verify that "Constrains to Margins" is turned off and choose **Items of new Constraints** for Update Frames
18. With the second effect view selected, switch to the Attributes Inspector. Set Blur Style to **Dark** and enable **Vibrancy**
19. Drag a label into the view of the second effect view and position it to the left side.  Again you may find it easiest to drag the label to the outline rather than the scene to ensure proper z-index placement as a subview. 
20. Set the label to **Name** and font to **System Bold** at **17 points** and color to **White**.
21. Pin the Name label's **leading space to 8** and set it's **vertical alignment to center in the container** with 0 offset. Using "Update Frames" in the resolve menu to let Xcode properly position the label.
22. With the Name label selected use ⌘+D to duplicate it. Position it to the right of the cell and change it's value to "Days"
23. Pin the Days label's **trailing space to 8** and set it's **vertical alignment to center** in the container with 0 offset. Using "Update Frames" in the resolve menu to let Xcode properly position the label.

At this point your user interface design is finished, but next you need to wire up the dynamic elements. Specifically the table view's delegate and datasource; the image view and both labels.

##10c) Wire up the interface

1. Select "Table View" in the Document Outline and CTRL+Drag to "Today View Controller", release and choose "dataSource" from the menu. Repeat this process and choose "delegate" as well.
2. Now your table view cell needs a custom class so that the labels and image view can be wired up. Fortunately there is already one in the Countdown target named `TargetDayCell.swift`. You can re-use this cell but first you must include it in the Counting Down target as well. But an even better solution would be to include it in the CountdownKit framework. Locate `TargetDayCell.swift` in the Project Navigator
3. Change the Target Membership from "Countdown" to "CountdownKit"  
 ***Note**: You can optionally move the file from the Countdown group to CountdownKit but it is not necessary for things to work. Ideally you'd want your project to be organized so it would make sense to do this "in the real world"*
4. Because you changed the target you need to update the app's storyboard. Open **Main.storyboard**
5. Locate and select **TargetDay** cell in the Document Outline
6. Switch to the Identity Inspector in the Utilities Pane
7. Set Module to **CountdownKit**
8. Now, back to the widget. Open **MainInterface.storyboard**
9. Select **Table View Cell** in the Document Outline
10. From the Identity Inspector set the class to **TargetDayCell**, by default Xcode should pick CountdownKit as the module, if not set it yourself.
11. Switch to Attributes Inspector and set Identifier to **TargetDay**
12. Open the Assistant Editor and verify that `TodayViewController.swift` is opened
13.  Create an outlet for your table view named `tableView`
14. In the Assistant Editor switch to `TargetDayCell.swift`
15. Wire up both labels and the image view
	- Name Label to `nameLabel`
	- Days Label to `daysLabel`
	- Image View to `dayImageView`

Great work! Your interface is laid out and wired up! Time to move on to the code.

