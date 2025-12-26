//+------------------------------------------------------------------+
//| EA untuk strategi MA200, BB, RSI, ATR dengan Trailing Stop        |
//+------------------------------------------------------------------+
extern int MA_Period = 200;
extern int BB_Period = 20;
extern double BB_Deviation = 2;
extern int RSI_Period = 14;
extern int ATR_Period = 14;
extern double ATR_Multiplier = 1.5;
extern double TrailingStop = 10; // Trailing stop dalam pips
extern int MagicNumber = 12345;

bool HasOpenPosition() {
   for (int i = 0; i < OrdersTotal(); i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
            return true;
         }
      }
   }
   return false;
}

void OnTick() {
   double ma200 = iMA(NULL, 0, MA_Period, 0, MODE_SMA, PRICE_CLOSE, 0);
   double upperBB = iBands(NULL, 0, BB_Period, BB_Deviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
   double lowerBB = iBands(NULL, 0, BB_Period, BB_Deviation, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double rsi = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 0);
   double atr = iATR(NULL, 0, ATR_Period, 0);

   // Buy condition
   if (Close[0] > ma200 && Close[0] <= lowerBB && rsi < 30 && !HasOpenPosition()) {
      double sl = Close[0] - (atr * ATR_Multiplier);
      double tp = Close[0] + (atr * ATR_Multiplier * 2);
      int ticket = OrderSend(Symbol(), OP_BUY, 0.1, Ask, 3, sl, tp, "Buy Order", MagicNumber, 0, Green);
      if (ticket < 0) {
         Print("Error opening buy order: ", GetLastError());
      }
   }

   // Sell condition
   if (Close[0] < ma200 && Close[0] >= upperBB && rsi > 70 && !HasOpenPosition()) {
      double sl = Close[0] + (atr * ATR_Multiplier);
      double tp = Close[0] - (atr * ATR_Multiplier * 2);
      int ticket = OrderSend(Symbol(), OP_SELL, 0.1, Bid, 3, sl, tp, "Sell Order", MagicNumber, 0, Red);
      if (ticket < 0) {
         Print("Error opening sell order: ", GetLastError());
      }
   }

   // Trailing Stop
   for (int i = 0; i < OrdersTotal(); i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
            if (OrderType() == OP_BUY) {
               double newSL = Bid - TrailingStop * Point;
               if (Bid - OrderStopLoss() > TrailingStop * Point && newSL > OrderStopLoss()) {
                  bool result = OrderModify(OrderTicket(), OrderOpenPrice(), newSL, OrderTakeProfit(), 0, Green);
                  if (!result) {
                     Print("Error modifying buy order: ", GetLastError());
                  }
               }
            } else if (OrderType() == OP_SELL) {
               double newSL = Ask + TrailingStop * Point;
               if (OrderStopLoss() - Ask > TrailingStop * Point && newSL < OrderStopLoss()) {
                  bool result = OrderModify(OrderTicket(), OrderOpenPrice(), newSL, OrderTakeProfit(), 0, Red);
                  if (!result) {
                     Print("Error modifying sell order: ", GetLastError());
                  }
               }
            }
         }
      }
   }
}
