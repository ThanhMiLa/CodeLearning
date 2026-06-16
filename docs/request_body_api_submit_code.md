{                                                                                                                                                                           
"problemId": 2,                                                                                                                                                           
"languageId": 76,                                                                                                                                                         
"sourceCode": "#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}"                                                                                                                                                                        
}


{                                                                                                                                                                           
"problemId": 5,                                                                                                                                                           
"contestId": 2,                                                                                                                                                           
"languageId": 76,                                                                                                                                                         
"sourceCode": "#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << \"\\n\";\n    }\n    return 0;\n}"
}


{                                                                                                                                                                             
"problemId": 7,                                                                                                                                                             
"contestId": 3,                                                                                                                                                             
"languageId": 76,                                                                                                                                                           
"sourceCode": "#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << \"\\n\";\n    return 0;\n}"                                                                                                                                         
}

{                                                                                                                                                                             
"problemId": 6,                                                                                                                                                             
"contestId": 3 ,                                                                                                                                                            
"languageId": 76,                                                                                                                                                           
"sourceCode": "#include <iostream>\n\nusing namespace std;\n\nlong long gcd(long long a, long long b) {\n    while (b != 0) {\n        long long temp = a % b;\n        a = b;\n        b = temp;\n    }\n    return a;\n}\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    long long a, b;\n    if (cin >> a >> b) {\n cout << gcd(a, b) << \"\\n\";\n    }\n    return 0;\n}"                                                                                                                         
}  

