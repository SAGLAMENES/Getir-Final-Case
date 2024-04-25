## Reflections on this VIPER Project
This project marks a  milestone for me as I ventured into VIPER architecture and programmatically building UI in iOS development. Transitioning from SwiftUI to VIPER was both exciting and challenging, requiring a shift in mindset.

## Learning Experience
Adapting to VIPER's structured architecture taught me the importance of modularization for code maintainability and scalability. Understanding the flow of data and interactions between VIPER components was a key learning curve.

## Challenges Faced
Conceptualizing the interaction between View, Interactor, Presenter, Entity, and Router layers was challenging. Building UI programmatically without Interface Builder demanded a deeper understanding of Auto Layout and constraints.

## Successes and Areas for Improvement
While the project isn't perfect, I'm proud of the progress made. There are areas needing refinement, like handling edge cases and improving code readability. However, the overall look and functionality of the app are promising.

# Product List View

<p align="center">
  <img src="https://github.com/SAGLAMENES/Getir-Final-Case/assets/108627652/4f0070d7-f944-43ce-bb75-7d5a51de8805" alt="Main Screen" width="300" height="500" title="Image Title">
</p>

The Product List View is a module in your iOS project responsible for displaying a list of products. It utilizes the VIPER architecture pattern for separation of concerns.

### Features
- Display products in both horizontal and vertical layouts.
- Allow users to interact with the products, such as adding or removing items from the shopping cart.
- Navigate to the product detail view or the shopping cart view.

### Usage
#### Setting Up
- Add the `ProductListView.swift`, `ProductListPresenter.swift`, `ProductListInteractor.swift`, and `ProductListRouter.swift` files to your Xcode project.
- Ensure that you have the necessary dependencies, such as UIKit, Foundation, and SDWebImage, imported in your files.

#### Creating the Module
- To create an instance of the Product List View module, use the `ProductListRouter` class's `createModule()` method.

#### Customization
- You can customize the appearance and behavior of the Product List View module as needed.
- Some key methods for customization include:
  - `setUpCollectionView()`: Sets up the UICollectionView to display the list of products.
  - `setUpNavigationBar()`: Configures the navigation bar with custom items, such as a shopping cart button.

#### Interacting with Products
- The Product List View handles user interaction through delegation. It conforms to various protocols such as `ProductListViewProtocol`, `ProductListPresenterProtocol`, and `ProductListInteractorProtocol` to respond to user actions and update the UI accordingly.

# Product Detail View

<p align="center">
  <img src="https://github.com/SAGLAMENES/Getir-Final-Case/assets/108627652/83e7ee8e-c0b0-47dd-bf36-7c660adf72b1" alt="Product Detail Screen" width="300" height="500" title="Image Title">
</p>

The Product Detail View is a module in your iOS project responsible for displaying detailed information about a specific product. It allows users to view product details such as name, price, description, and image, as well as interact with the product, such as adding it to the shopping cart.

### Features
- Display detailed information about a specific product, including its name, price, description, and image.
- Allow users to interact with the product by adding it to the shopping cart.
- Provide options for users to increase or decrease the quantity of the product in the cart.

### Setting Up
- Add the `ProductDetailViewController.swift` file to your Xcode project.
- Ensure that you have the necessary dependencies, such as UIKit and SDWebImage, imported in your file.

### Customization
- You can customize the appearance and behavior of the Product Detail View module as needed.
- Some key methods for customization include:
  - `setUpView()`: Sets up the UI elements and constraints for displaying the product details.
  - Customize UI elements such as labels, buttons, and image views according to your design requirements.

### Interacting with Products
- The Product Detail View allows users to interact with the product by adding it to the shopping cart. It handles user interaction through delegation and target-action mechanisms.

#### increaseButtonTapped()
- Handles the action when the user taps the increase button to add more units of the product to the cart.

#### decreaseButtonTapped()
- Handles the action when the user taps the decrease button to remove units of the product from the cart.

#### addButton()
- Handles the action when the user taps the "Add to Cart" button to add the product to the cart.

# ShoppingCartListViewController

<p align="center">
  <img src="https://github.com/SAGLAMENES/Getir-Final-Case/assets/108627652/b6e7de3a-942b-44cb-8816-1dbb40ff643a" alt="Total Product Count" width="300" height="500" title="Image Title">
</p>

ShoppingCartListViewController is a view controller responsible for displaying the shopping cart items and handling user interactions related to the shopping cart.

### Overview
This view controller consists of the following components:

- UITableView: Displays the list of products added to the shopping cart.
- Complete Shop Button: Allows the user to complete the shopping process.

### Responsibilities
- Display the list of products in the shopping cart.
- Allow users to increase or decrease the quantity of each product.
- Navigate to the product detail screen when a product is selected.
- Provide an option to complete the shopping process.

### Components
- `ShoppingCartListViewController`: The main view controller responsible for managing the view hierarchy and handling user interactions.
- `ShoppingCartListPresenter`: Mediates between the view and the interactor, handling user inputs and updating the view accordingly.
- `ShoppingCartListInteractor`: Responsible for fetching the shopping cart items and managing data-related tasks.
- `ShoppingCartListRouter`: Handles navigation between view controllers.

### Protocols
- `ShoppingCartListViewControllerProtocol`: Defines methods for updating the view and handling user interactions.
- `ShoppingCartListPresenterProtocol`: Defines methods for managing user inputs and updating the view.
- `ShoppingCartListInteractorProtocol`: Defines methods for fetching shopping cart items and managing data-related tasks.
- `ShoppingCellDelegate`: Handles user interactions within the table view cells.

### Usage
- To use `ShoppingCartListViewController`:
  - Initialize the view controller using `ShoppingCartListRouter.buildShoppingCartVC()`.
  - Set up the presenter, interactor, and router.
  - Implement the necessary protocols for communication between components.
  - Present the view controller as required.
