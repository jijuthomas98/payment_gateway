import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Razorpay razorpay ;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initstate (){
    super.initState();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut(){
    var options = {
      "key" : "rzp_test_QnlhvGvB5rLApZ" ,
      "amount" : num.parse(textEditingController.text)*100,
      "name" :"Sample App" ,
      "Decs" : "Testing the app" ,
      "prefill": {
        "E-mail":"amul@gmail.com"
    },
      "external":{
        "wallets":["paytm" , "phonepe" , "airtelmoney"]
      }
    };
    try{
        razorpay.open(options);
    }catch(e){
      print(e);
    }
  }

  void handlerPaymentSuccess(){       //if any animation is required in later stages then this is where the animation is degfined
    print("Payment Successful");
    Toast.show("Payment Successful", context);
  }

  void handlerPaymentError(){
    print("Some error occured ");
    Toast.show("Some error occured", context);

  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet" , context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Gateway'),
      ),
      body:Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [

            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'Input an amount',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: Colors.cyan,
              child: Text('Pay Now!!', style: TextStyle(
                color: Colors.white,

              ),
              ),
              onPressed: (){
                openCheckOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
