#include <iostream>
#include <vector>
#include <list>
#include <map>
#include <string>
#include <algorithm>
using namespace std;

int main(){
    vector<int> v1 = {1,2,3}; //like single ended queue, can't push/pop it to front but can read it
    vector<int> v2 {1, 2, 3};
    vector<int> v3 (5,1); // 5 elements with value 1

    for(int i: v1) cout<<i<<endl;

    v1.push_back(4);// add element at end
    v1.pop_back(); // remove element at end
    v1.at(2) = 1;  // change element at index 2

    v1.size(); // size of vector
    v1.clear(); // clear all elements
    bool is_v1_empty = v1.empty(); // check if vector is empty
    v1.resize(5); // resize vector to 5 elements
    v1.front(); // first element
    v1.back(); // last element
    v1.capacity(); // capacity of vector

    list<int> l1 = {1,2,3}; //doubly linked list
    list<int> l2 (5,1); // 5 elements with value 1
    l1.push_front(4); // add element at front
    l1.pop_front(); // remove element at front
    l1.push_back(4);// add element at end
    l1.pop_back(); // remove element at end
    l1.front(); // first element
    l1.back(); // last element
    l1.remove(1); // remove all elements with value 1

    list<string> l3 = {"abc","def","ghi"};
    for(string &s: l3) s="hi";//change all elements

    map<int, string> m1 = {{1,"abc"},{2,"bcd"},{3,"def"}}; // key value pair
    for (auto var: m1) cout<<var.first<<" "<<var.second<<endl;
    m1.insert(make_pair<int,string>(4,"efg")); // insert key value pair
    m1[1] = "xyz"; // change value of key 1
    
    if (m1.find(5) != m1.end()) cout << "found m1[5]" << endl; // find key value pair with key 2
    else cout << "not found m1[5]" << endl;
    
    cout << "map find " << m1[8] << endl; // find key value pair with key 2
    
    m1.erase(4);                         // erase key value pair
    m1.clear(); // clear all elements
    bool is_m1_empty = m1.empty(); // check if map is empty
    m1.size(); // size of map
    m1.count(2); // count key value pair with key 2

    //stl iterators
    vector<int>::iterator it1 = v1.begin();
    sort(v1.begin(),v1.end()); // sort vector
    it1 = min_element(v1.begin(),v1.end()); // min element
    it1 = max_element(v1.begin(),v1.end()); // max element
    cout<<*it1<<endl; // dereference iterator
    reverse(v1.begin(),v1.end()); // reverse vector

    l1.unique();  // remove consecutive duplicates
    l1.sort();    // sort vector

    return 0;
}