import csv
import pandas as pd
'''Paramaters: String symbol for example bitcoin is 'USDT_BTC,
    time seperation given available according to poloniex chart periods, 5 minutes, 15 minutes, 30 minutes,
    2 hours, 4 hours and 24 hours given in seconds = 300,900,1800,7200,14400,86400
    data returned from first available record
    from poloniex website:
    Call: https://poloniex.com/public?command=returnChartData&currencyPair=BTC_XMR&start=1405699200&end=9999999999&period=14400
    where pair in this instance is BTC against XMR (Monero).
    Initially wanted to do gdax but they are limited to to 200 requests at a time so it would take a number of extra requests to get all data

'''

def sample():
    api = 'https://poloniex.com/public?command=returnChartData&currencyPair=BTC_XMR&start=1405699200&end=9999999999&period=14400'
    #https://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_json.html
    dataset = pd.read_json(dataset)
    #https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.set_index.html
    dataset.set_index('date',append=False, inplace=True, verify_integrity=False)
    return dataset


#I'm interested in looking at USD pairs, many currencies are valued against each other - and many people will trade crypto against crypto to avoid paying tax on trades
#the below allows me to grab data from start=0 for bitcoin

def cryptocurrency_data(pair, timeperiod):
    #replace pair with a variable, timeperiod with a variable also
    api = 'https://poloniex.com/public?command=returnChartData&currencyPair='+pair+'&start=0&end=9999999999&period='+str(timeperiod)
    #https://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_json.html
    dataset = pd.read_json(api)
    #https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.set_index.html

    dataset.to_csv(pair+'.csv', index=False, header =True)

    return dataset


cryptocurrency_data('USDT_BTC', 86400)

#it is also possible to grab data for all crytpocurrencies using the same function and just changing out the pair value or a function can be used


currency_pairs = ["USDT_BTC", "USDT_XRP", "USDT_ETH","USDT_ETC", "USDT_LTC", "USDT_XMR","USDT_DASH","USDT_ZEC"]
for i in currency_pairs:
    cryptocurrency_data(i, 86400)

#flask json google charts
