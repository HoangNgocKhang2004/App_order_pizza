class ApiRoute {
  // static const String baseUrl = 'http://0.0.0.0:5021';
  static const String baseUrl = 'http://10.0.2.2:5021';


  // Auth
  static const String login = '$baseUrl/api/Auth/login';
  static const String register = '$baseUrl/api/Auth/register';

  // Users
  static const String getAllUsers = '$baseUrl/api/Users';
  static const String getUserById = '$baseUrl/api/Users/{id}';
  static const String createUser = '$baseUrl/api/Users';
  static const String updateUser = '$baseUrl/api/Users/{id}';
  static const String deleteUser = '$baseUrl/api/Users/{id}';

  // Addresses
  static const String getAllAddresses = '$baseUrl/api/Address';
  static const String getAddressById = '$baseUrl/api/Address/{id}';
  static const String createAddress = '$baseUrl/api/Address';
  static const String updateAddress = '$baseUrl/api/Address/{id}';
  static const String deleteAddress = '$baseUrl/api/Address/{id}';

  // Categories & SubCategories
  static const String getAllCategories = '$baseUrl/api/Category';
  static const String getCategoryById = '$baseUrl/api/Category/{id}';
  static const String createCategory = '$baseUrl/api/Category';
  static const String updateCategory = '$baseUrl/api/Category/{id}';
  static const String deleteCategory = '$baseUrl/api/Category/{id}';

  static const String getAllSubCategories = '$baseUrl/api/SubCategory';
  static const String getSubCategoryById = '$baseUrl/api/SubCategory/{id}';
  static const String createSubCategory = '$baseUrl/api/SubCategory';
  static const String updateSubCategory = '$baseUrl/api/SubCategory/{id}';
  static const String deleteSubCategory = '$baseUrl/api/SubCategory/{id}';

  // Products & Toppings & Promotions
  static const String getAllProducts = '$baseUrl/api/Products';
  static const String getProductById = '$baseUrl/api/Products/{id}';
  static const String createProduct = '$baseUrl/api/Products';
  static const String updateProduct = '$baseUrl/api/Products/{id}';
  static const String deleteProduct = '$baseUrl/api/Products/{id}';

  static const String getAllToppings = '$baseUrl/api/Topping';
  static const String getToppingById = '$baseUrl/api/Topping/{id}';
  static const String createTopping = '$baseUrl/api/Topping';
  static const String updateTopping = '$baseUrl/api/Topping/{id}';
  static const String deleteTopping = '$baseUrl/api/Topping/{id}';

  static const String getAllPromotions = '$baseUrl/api/Promotions';
  static const String getPromotionById = '$baseUrl/api/Promotions/{id}';
  static const String createPromotion = '$baseUrl/api/Promotions';
  static const String updatePromotion = '$baseUrl/api/Promotions/{id}';
  static const String deletePromotion = '$baseUrl/api/Promotions/{id}';

  // Orders & OrderDetails
  static const String getAllOrders = '$baseUrl/api/Order';
  static const String getOrderById = '$baseUrl/api/Order/{id}';
  static const String createOrder = '$baseUrl/api/Order';
  static const String updateOrder = '$baseUrl/api/Order/{id}';
  static const String deleteOrder = '$baseUrl/api/Order/{id}';

  static const String getAllOrderDetails = '$baseUrl/api/OrderDetail';
  static const String getOrderDetailById = '$baseUrl/api/OrderDetail/{id}';
  static const String createOrderDetail = '$baseUrl/api/OrderDetail';
  static const String updateOrderDetail = '$baseUrl/api/OrderDetail/{id}';
  static const String deleteOrderDetail = '$baseUrl/api/OrderDetail/{id}';

  // Feedbacks
  static const String getAllFeedbacks = '$baseUrl/api/Feedback';
  static const String getFeedbackById = '$baseUrl/api/Feedback/{id}';
  static const String createFeedback = '$baseUrl/api/Feedback';
  static const String updateFeedback = '$baseUrl/api/Feedback/{id}';
  static const String deleteFeedback = '$baseUrl/api/Feedback/{id}';

  // Suggestions
  static const String getAllSuggestions = '$baseUrl/api/Suggestion';
  static const String getSuggestionById = '$baseUrl/api/Suggestion/{id}';
  static const String createSuggestion = '$baseUrl/api/Suggestion';
  static const String updateSuggestion = '$baseUrl/api/Suggestion/{id}';
  static const String deleteSuggestion = '$baseUrl/api/Suggestion/{id}';

  //Recommendations
  static const String getRecommendations = '$baseUrl/api/Recommendations';

  //Ranking
  static const String getRanking = '$baseUrl/api/Rankings';
}
