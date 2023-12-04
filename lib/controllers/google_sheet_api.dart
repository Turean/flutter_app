import 'package:gsheets/gsheets.dart';

class GoogleSheetApi{
  //create credentials
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "galaxy-ray-406604",
    "private_key_id": "c9f1a7e1e370faac2e64512d4336258d315643e1",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCVdf3qZnaDE5M1\nNwWKQ0zvjYiXh6xjrVZJ5PflD2IEMwitWSmeDjgylWFaUNxWkMw5mX0zrNFioZLi\nUWcqu1GLgd5ecY69f+aV1tEqoKtH0Y2kq4Oynta3EvsOXUKWw16bDLvGoO/fb1jD\n4h5xzlI7JxmvGANfBbe8LGRGQevm5RC9ywjB7T7zONEgBqgtCO83XtoV9qfQVBhd\n9SnLwn6miB26LdAmh+vbbcLikPVyKk/o8sGshajurW55EKpmwT3gSbAPM2AaRLuo\nLLWutETf0hUT3lfPd07OXPF1E7OP2zFyCp1HtYj0sfvgZcSy6MJJ2iOEnvxTZ7u1\np092AZFdAgMBAAECggEADRQ5NxTmVAwXerWo53OCPQhOpqv5uvNFNMwzoTjaY/Gv\nVbQSv0ERS+PklAm1bmHXbUbwPOBnplDrUKC8/XFM7n9b3TnkutKBdCVLQoay1mMR\nGRLlQHFD6ttfWt9wX08TbVAM8pHMy+mrg+C6t0zNx11hkv/v85XFgVMFJ1zHbvoE\nY01TYdFoXRXSMdAjShwJbkUleVGWAjboXHQIuOqA+d2j+SOjWhtowpPzktJC9Wp3\n8zoUrbQlCEt4Uw9y6y+j2o9Ty1TpReV2YJKYdr/ID/fgXGAxakpt2a/zRO4ROxOE\ngUa5icWximOYEZld5+Coc6LLyiD6G4SgTqZZuwuGpQKBgQDF9rJiqbDSP31J0Y2I\nxicSAfEu6zpSf7cgq7xHTq98E4EnAHrZSteCUhkkeY2ZvrU0kHTWsnBAekLAFDdF\nk4tmTZw2vJqExEq5US4JolIQZPme7BryB3DxhmDXTyID8h6WoQ/1wqho5i2FbzsT\ngQj/yg9YjBhdpltHsjAOS+nNPwKBgQDBRyGim0IswhkIdg1n+Pfvlf/qLOApwcZS\nS6uvsUp0m7+vC9nHD+G+ThBcOM+tUGLgy0FZG+HztM6ko57fxl/M2dKkR6EWfXLV\nHqmievxwN4itrImC3SVK1yX5heaypShsttsDoXm3SYXqUG1yx5wpsIan7uT5cqx9\nJuyAiHJOYwKBgQClNTU324+iVrPTeBta6qtOfuptkoeQs977V/b/t24B6TEegGsF\njkz+CE/NPdfrV9lXrbqkNjQxyxaLwBNEcFakoN5eW9XEOSB3OYVnKty7q9kaRMZT\n99vM5K1K4lJr4pKeeHmeSr5LFNUmh2ZQ553AAjv+VKQ8+4kv80fhln7e9wKBgEbi\ns69Tif2oYk38HgaYBTbVqLpWIxCthPMB1cHmIAyMYszsZ77eUEjfkJiCLYi/BsSz\nRxBLbZ9YHMG9ULN5qgETknG145q//7GyQTzaJmNxuqsXsIdSXC8KoV7WgTnb4Oue\nVM0MF/vk9zxsqveBxgB0Qa6tq0ThjemIsQyi/mlJAoGBAIUJdudRRSCm9A0MpfW6\naaxHjYAYk1uP5c1tyjrXFPpiVe29vGVKdPBoxHLNKWu3FFz2GSTR1N4B9CsWuCej\n/g29yCAOkhQ1wsE4kYrdcOsyFjSUAzHsAQvOCcGX9OZ8MWQGnUIBXy3kr0iw8Sah\nmyjVYTTX7UUenUkf14nAce4U\n-----END PRIVATE KEY-----\n",
    "client_email": "galaxy-ray@galaxy-ray-406604.iam.gserviceaccount.com",
    "client_id": "103513055047594177316",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/galaxy-ray%40galaxy-ray-406604.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  
  ''';

  //set up and connect to the spreadsheet
  static const _spreadsheetId = '1BhNVr0PbkLSH9RyxNJMvm4BoX_wA1zt25EIcHO1LFnQ';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  //initialize the spreadsheet
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  //count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
        .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
      await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
      await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
      await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  static Future<void> deleteTransaction(String transactionName) async {
    if (_worksheet == null) return;

    // Find the index where the transactionName is located
    int rowIndex = -1;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][0] == transactionName) {
        rowIndex = i;
        break;
      }
    }

    // If the transactionName was found, delete the row
    if (rowIndex != -1) {
      // Adjust the index to match the sheet row index
      final sheetRowIndex = rowIndex + 2; // Rows in GSheets start from 2

      // Use the deleteRow method to delete the entire row
      await _worksheet!.deleteRow(sheetRowIndex);

      currentTransactions.removeAt(rowIndex);
      numberOfTransactions--; // Update numberOfTransactions after deletion
    }
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }

}