# MA200-BB-RSI-ATR Trading Strategy Expert Advisor

## Overview

This Expert Advisor (EA) implements a comprehensive trading strategy that combines multiple technical indicators for informed trading decisions on the MetaTrader 4 (MT4) platform.

## Strategy Components

### Technical Indicators Used

1. **Moving Average (MA200)**: 200-period Simple Moving Average
   - Used to determine overall market trend
   - Buy signals only when price is above MA200
   - Sell signals only when price is below MA200

2. **Bollinger Bands (BB)**: 20-period with 2 standard deviations
   - Identifies overbought and oversold conditions
   - Buy signals when price touches or crosses below lower band
   - Sell signals when price touches or crosses above upper band

3. **Relative Strength Index (RSI)**: 14-period
   - Measures momentum and identifies reversal points
   - Buy signals when RSI < 30 (oversold)
   - Sell signals when RSI > 70 (overbought)

4. **Average True Range (ATR)**: 14-period
   - Measures market volatility
   - Used for dynamic Stop Loss and Take Profit calculations
   - Adapts position sizing to market conditions

## Key Features

- **Order Management**: Prevents multiple orders by checking for open positions before placing new trades
- **Magic Number**: Uses unique identifier (12345) to manage only its own orders
- **Error Handling**: Includes error checking and logging for OrderSend and OrderModify operations
- **Symbol Filtering**: Trailing stop only affects orders for the current chart symbol
- **Dynamic Risk Management**: ATR-based stop loss and take profit adjust to market volatility

## Trading Rules

### Buy Conditions
All of the following must be true:
- Current price (Close[0]) > MA200 (uptrend confirmation)
- Current price (Close[0]) <= Lower Bollinger Band (oversold)
- RSI < 30 (oversold momentum)

When conditions are met:
- Stop Loss: Current price - (ATR × 1.5)
- Take Profit: Current price + (ATR × 1.5 × 2)
- Lot Size: 0.1 (fixed)

### Sell Conditions
All of the following must be true:
- Current price (Close[0]) < MA200 (downtrend confirmation)
- Current price (Close[0]) >= Upper Bollinger Band (overbought)
- RSI > 70 (overbought momentum)

When conditions are met:
- Stop Loss: Current price + (ATR × 1.5)
- Take Profit: Current price - (ATR × 1.5 × 2)
- Lot Size: 0.1 (fixed)

## Trailing Stop Feature

The EA includes an automatic trailing stop mechanism that protects profits:

- **For Buy Orders**: Trailing stop moves up as price increases
  - Activates when profit exceeds 10 pips
  - Maintains 10-pip distance from current price
  
- **For Sell Orders**: Trailing stop moves down as price decreases
  - Activates when profit exceeds 10 pips
  - Maintains 10-pip distance from current price

## Configurable Parameters

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| MA_Period | 200 | Moving Average period |
| BB_Period | 20 | Bollinger Bands period |
| BB_Deviation | 2.0 | Bollinger Bands standard deviation |
| RSI_Period | 14 | RSI period |
| ATR_Period | 14 | ATR period |
| ATR_Multiplier | 1.5 | Multiplier for ATR-based SL/TP |
| TrailingStop | 10 | Trailing stop distance in pips |
| MagicNumber | 12345 | Unique identifier for EA's orders |

## Installation

1. Copy `MA200_BB_RSI_ATR_Strategy.mq4` to your MetaTrader 4 data folder:
   - File → Open Data Folder → MQL4 → Experts

2. Restart MetaTrader 4 or click "Refresh" in the Navigator panel

3. Drag and drop the EA onto your desired chart

4. Adjust parameters as needed in the EA settings

5. Enable AutoTrading in MetaTrader 4

## Risk Warning

⚠️ **IMPORTANT**: This EA is provided for educational purposes. Trading forex carries substantial risk and may not be suitable for all investors. The high degree of leverage can work against you as well as for you. Before deciding to trade forex, you should carefully consider your investment objectives, level of experience, and risk appetite.

- Always test on a demo account first
- Use appropriate risk management
- Never risk more than you can afford to lose
- Past performance does not guarantee future results

## Usage Recommendations

1. **Backtesting**: Test the strategy on historical data before live trading
2. **Demo Trading**: Run on a demo account for at least 1-2 months
3. **Risk Management**: Never risk more than 1-2% of account per trade
4. **Diversification**: Don't rely solely on one strategy
5. **Market Conditions**: Strategy may perform differently in trending vs ranging markets

## Strategy Characteristics

- **Type**: Trend-following with mean reversion elements
- **Timeframe**: Works on any timeframe (recommended: H1, H4, D1)
- **Pairs**: Any forex pair (test on specific pairs first)
- **Risk Level**: Medium to High (depending on lot size and leverage)

## Technical Requirements

- MetaTrader 4 platform
- Active forex broker account
- Stable internet connection
- VPS recommended for 24/7 operation

## Support and Modifications

This EA can be customized to fit different trading styles:
- Adjust indicator periods for different market sensitivities
- Modify lot sizes for different risk profiles
- Change ATR multiplier for wider/tighter stops
- Add additional filters or conditions

## License

This Expert Advisor is provided as-is without any warranty. Use at your own risk.

---

**Author**: Trading Strategy Implementation  
**Version**: 1.0  
**Last Updated**: 2025  
**Platform**: MetaTrader 4 (MQL4)
