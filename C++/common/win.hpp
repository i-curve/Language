#pragma once
#ifndef COMMON_HEADER_ONLY 
#ifdef WIN32
#include <atlstr.h>

// 调试输出错误信息
class OutputMsg {
private:
    CString msg;

public:
    template <typename... T>
    CString Format(CString formatPar, T... args) {
        msg.Format(formatPar, args...);
        return msg;
    }
};

inline OutputMsg DeMsg;
inline OutputMsg InMsg;
inline OutputMsg ErMsg;

// 字节序转换
/// <summary>
/// unicode 字符到多字节转换
/// </summary>
/// <param name="srcstrW"></param>
/// <returns></returns>
string CStringW2string(CString srcstrW) {
    int dBufSize = WideCharToMultiByte(CP_OEMCP, 0, srcstrW, -1, NULL, 0, NULL, FALSE);
    char *pBuf = new char[dBufSize + 1];
    memset(pBuf, 0, dBufSize + 1);
    WideCharToMultiByte(CP_OEMCP, 0, srcstrW, -1, pBuf, dBufSize, NULL, FALSE);
    pBuf[dBufSize] = '\0';
    string tmpstr = pBuf;
    delete pBuf;
    pBuf = NULL;
    return tmpstr;
}

/// <summary>
/// char2CStringW 多字节到unicode转换
/// </summary>
/// <param name="pstr"></param>
/// <returns></returns>
CStringW char2CStringW(const char *pstr) {
    int dBufSize = MultiByteToWideChar(CP_UTF8, 0, pstr, -1, NULL, 0);
    WCHAR *pBuf = new WCHAR[dBufSize + 1];
    memset(pBuf, 0, dBufSize + 1);
    MultiByteToWideChar(CP_UTF8, 0, pstr, -1, pBuf, dBufSize);
    pBuf[dBufSize] = '\0';
    CStringW tmpstrW = pBuf;
    delete pBuf;
    return tmpstrW;
}
#endif
#endif