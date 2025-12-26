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

void OnTick() {
   double ma200 = iMA(NULL, 0, MA_Period, 0, MODE_SMA, PRICE_CLOSE, 0);
   double upperBB = iBands(NULL, 0, BB_Period, BB_Deviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
   double lowerBB = iBands(NULL, 0, BB_Period, BB_Deviation, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double rsi = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 0);
   double atr = iATR(NULL, 0, ATR_Period, 0);

   // Buy condition
   if (Close[0] > ma200 && Close[0] <= lowerBB && rsi < 30) {
      double sl = Close[0] - (atr * ATR_Multiplier);
      double tp = Close[0] + (atr * ATR_Multiplier * 2);
      OrderSend(Symbol(), OP_BUY, 0.1, Ask, 3, sl, tp, "Buy Order", 0, 0, Green);
   }

   // Sell condition
   if (Close[0] < ma200 && Close[0] >= upperBB && rsi > 70) {
      double sl = Close[0] + (atr * ATR_Multiplier);
      double tp = Close[0] - (atr * ATR_Multiplier * 2);
      OrderSend(Symbol(), OP_SELL, 0.1, Bid, 3, sl, tp, "Sell Order", 0, 0, Red);
   }

   // Trailing Stop
   for (int i = 0; i < OrdersTotal(); i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderType() == OP_BUY) {
            if (Bid - OrderStopLoss() > TrailingStop * Point) {
               OrderModify(OrderTicket(), OrderOpenPrice(), Bid - TrailingStop * Point, OrderTakeProfit(), 0, Green);
            }
         } else if (OrderType() == OP_SELL) {
            if (OrderStopLoss() - Ask > TrailingStop * Point) {
               OrderModify(OrderTicket(), OrderOpenPrice(), Ask + TrailingStop * Point, OrderTakeProfit(), 0, Red);
            }
         }
      }
   }
}
