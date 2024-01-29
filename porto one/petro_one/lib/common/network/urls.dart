class Urls {
  static const String _baseURL = 'https://tgi.com.sa/Demo/crm/api';

  /// staffs apis
  static String get postStaff => '$_baseURL/staffs';
  static String deleteStaff(String id) => '$_baseURL/delete/staffs/$id';
  static String putStaff(String id) => '$_baseURL/staffs/$id';
  static String getStaff(String id) => '$_baseURL/staffs/$id';
  static String getAllStaffs() => '$_baseURL/staffs';
  static String searchStaff(String keyword) =>
      '$_baseURL/staffs/search/$keyword';

  /// Customers apis
  static String get postCustomer => '$_baseURL/customers';
  static String deleteCustomer(String id) => '$_baseURL/delete/customers/$id';
  static String putCustomer(String id) => '$_baseURL/customers/$id';
  static String getCustomer(String id) => '$_baseURL/customers/$id';
  static String getAllCustomers() => '$_baseURL/customers';
  static String searchCustomer(String keyword) =>
      '$_baseURL/customers/search/$keyword';

  /// projects apis
  static String get postProject => '$_baseURL/projects';
  static String deleteproject(String id) => '$_baseURL/delete/projects/$id';
  static String putProject(String id) => '$_baseURL/projects/$id';
  static String getProject(String id) => '$_baseURL/projects/$id';
  static String getAllProjects() => '$_baseURL/projects';
  static String searchProject(String keyword) =>
      '$_baseURL/projects/search/$keyword';

  /// Proposal apis
  static String get postProposal => '$_baseURL/proposals';
  static String deleteProposal(String id) => '$_baseURL/delete/proposals/$id';
  static String putProposal(String id) => '$_baseURL/proposals/$id';
  static String getProposal(String id) => '$_baseURL/proposals/$id';
  static String getAllProposals() => '$_baseURL/proposals';
  static String searchProposal(String keyword) =>
      '$_baseURL/proposals/search/$keyword';

  /// contacts apis
  static String get postContact => '$_baseURL/contacts';
  static String deleteContact(String id) => '$_baseURL/delete/contacts/$id';
  static String putContact(String id) => '$_baseURL/contacts/$id';
  static String getContact(
          {required String customerId, required String contactId}) =>
      '$_baseURL/contacts/$customerId/$contactId';
  static String searchContacts({required String keyword}) =>
      '$_baseURL/contacts/search/$keyword';

  /// invoices apis
  static String get postInvoice => '$_baseURL/invoices';
  static String deleteInvoice(String id) => '$_baseURL/delete/invoices/$id';
  static String putInvoice(String id) => '$_baseURL/invoices/$id';
  static String getInvoice({required String invoiceId}) =>
      '$_baseURL/invoices/$invoiceId';
  static String getAllInvoices() => '$_baseURL/invoices';

  /// task apis
  static String get postTask => '$_baseURL/tasks';
  static String deleteTask(String id) => '$_baseURL/delete/tasks/$id';
  static String putTask(String id) => '$_baseURL/tasks/$id';
  static String getTask(String id) => '$_baseURL/tasks/$id';
  static String searchTasks({required String keyword}) =>
      '$_baseURL/tasks/search/$keyword';

  /// payment apis
  static String getPayments() => '$_baseURL/payments/';
  static String searchPayment({required String keyword}) =>
      '$_baseURL/payments/search/$keyword';

  ///Items apis
  static String getItems() => '$_baseURL/items/';
  static String searchItem({required String keyword}) =>
      '$_baseURL/items/search/$keyword';

  static Map<String, String> header(String token, {bool isPut = false}) => {
        'Content-Type': 'application/json',
        if (isPut) 'Content-Type': 'text/plain',
        "authtoken": token,
      };
}

class ServerService<T> {
  //timeout duration
  Future<T> timeOutMethod(Future<T> Function() function) async {
    return await Future.delayed(const Duration(seconds: 5), () async {
      return await function();
    });
  }
}
