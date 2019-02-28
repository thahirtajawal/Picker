#  SheetPresenter

SheetPresenter provides an easy way to present view controllers as action sheets. It serves as a container for your action sheet controller and manages all the presentation required.

## Usage

Implement the `SheetPresentable` protocol on the controller that you want to present and call the `present(on:)` method to show your action sheet.

```swift
// implement SheetPresentable protocol
class ActionSheetController: UIViewController, SheetPresentable { }

// use present(on:) method to show action sheet
let actionSheet = ActionSheetController.instantiate(with: .someStoryoard)
actionSheet.present(on: someController)
```
Alternatively you can use the `Sheet Presenter` segue to wire up your controller from storyboard.

## Customizations

 The `SheetPresentable` protocol offers two properties for customizations.
 
 **Height**
 
 Determines the height of the sheet. The maximum and default height of the action sheet is half of the controller presenting the sheet. Update this property if the sheet is small and doesn't need to cover half of the presenting controller.
 
 ```swift
 var sheetPresenterHeight: CGFloat
 ```
**Dismissing**
 #### `var shouldDimissWhenTappedOutside: Bool`
 Determines whether to dismiss the sheet when tapped outside. Defaults to `true`.
