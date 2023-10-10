

const constantsUser = 'users';
const constantsfavoriteUsers = 'favoriteUsers';
const tconstantsTransactions = "transactions";
const constantsNotifications = 'notifications';
const constantsLogFailure='Failure';
const constantsLogException = 'Exception';
const constantsLogErrorFirebaseAuth ='FirebaseAuthError';
const constantsWallet = 'wallets';
const constantsAssets = 'assets';





class HttpRoutes {
  static const  transaction = _Transaction();
  static const user = _User();
  static const accountBank = _AccountBank();
  
}

class _User {
  const _User();
  final String me = '/user/me';
  final String kyc = '/user/kyc';
  final String root = '/user';
}

class _Transaction {
  const _Transaction();
  final String qrCode = '/transaction/qrcode';
  final String createTransactionBetweenAcc = '/transaction/between-accounts';
  final String userAlreadyExists = '/admin/user/verify';
  final String validateKey = '/transaction/validate-key';
  final String root = '/transaction';
  final String pixCashout ='/transaction/pix-out';
  final String myTransactions = '/transaction/my-transactions';
}

class _AccountBank {
  const _AccountBank();
  final String account = '/account';

}

class PaymentsType {
  static const p2p = 'p2p';
  static const pix = 'key';
  static const qrcode ='qrcode';
}

class TransactionAction {
  static const cashIn = 'CASH_IN';
  static const cashOut = 'CASH_OUT';
  static const recharge ='RECHARGE';
}

class  TransactionUtilsStatus {
  static const processing = 'PROCESSING';
  static const completed = 'COMPLETED';
  static const canceled = 'CANCELED';
}
enum KYCSTATUSRESPONSE{ idle,pending,inReview,completed,error}
enum StringUtilsMethodsEnum {cpf,cnpj,email,phone,random,qrcode,copyAndPaste}

StringUtilsMethodsEnum stringToEnumMethod(String key){
  return StringUtilsMethodsEnum.values.firstWhere((element) => element.name == key,orElse: ()=>StringUtilsMethodsEnum.random);
}
class StringUtils {
  static const keyPayment='keyPayment';
  static const method='method';
  static const paymentType ='paymentType';
  static const amount ='amount';
  static const transactionId ='trasactionId';
  static const sendMethod ='send';
  static const receiveMethod ='receive';
  static const document = 'document';
  static const phone = 'phone';
  static const title = 'title';
  static const accountBankTypeDefault = 'DEFAULT';
  static const accountBankTypeReceiver = 'RECEIVER_ACCOUNT';
  static const accountBankTypeOrigin = 'ORIGIN_ACCOUNT';
  static const scanner = 'scanner';
  static const email = 'email';
  static const name = 'name';
  static const birthDay = 'birth-day';
  static const username ='username';
  static const id ='id';
  static const pincodeValidation ='pincodeValidation';


}

