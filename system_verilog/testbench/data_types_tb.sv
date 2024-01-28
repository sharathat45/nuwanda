/*
x or X	Logic state X - variable/net has either 0/1 - we just don't know
z or Z	Logic state Z - net has high impedence - maybe the wire is not connected and is floating

4 state data types: (0,1,x,z) logic, reg
2 state data types: (0,1) bit

shortint: 16 bit signed
longint: 32 bit signed
byte: default signed
logic[7:0]: default unsigned

typedef enum {RED=2, YELLOW, GREEN}light_1; //integer type
typedef enum bit[1:0] {RED, YELLOW, GREEN}light_2; //bit type
1RED : error cannot have number at starting
light_2 traffic=YELLOW; //methods: traffic.first(), .last(), next, prev, num, name

typedef enum {RED[3]}light_3; //RED0 = 0, RED1 = 1, RED2 = 2
typedef enum {RED[3:5]}light_4; //RED3 = 0, RED4 = 1
typedef enum {RED[3]=4}light_5; //RED0 = 4, RED1 = 5, RED2 = 6

static array:
- packed array
    bit [7:0]x;
    bit [3:0][7:0]m_x;
    bit [2:0][3:0][7:0]mm_x; => mm_x[0,1,2]=32'habcd_abcd

- unpacked array
    logic [31:0]FIFO[0:DEPTH-1];
    byte stack[8];
    byte stack[2][4]; 2 rows 4 col
    byte [3:0][7:0]stack[2][4];

dynamic array:
    int arr[];
        arr = new[5];
    bit [7:0]x[];
        x = new[5];

associative array:
    int arr[string];
        arr = '{"ad":1, "bc":2}; => arr["ad"]
    int arr[] [string]; => dynamic
        arr = new[2]
        arr[0] = '{"ab":1, "cd":2};
        arr[1] = '{"ab":1, "cd":2};
*/


module data_types_tb();

int a = 1;
real b = 3.278987, c = 1e6;

typedef struct {
    int coins;
    real dollars;
}money;
money wallet;
money wallet_arr [1:0];

longint unsigned var_a;
shortint unsigned var_b;

string firstname = "Joey";
string lastname = "tribianni";

int myarr[0:4] = '{1,2,3,4,5};
int urarr[5];
int marr[5][5];
int res[$];
int i=0,j=0;

int bounded_q [$:10]; //depth 10
bit [3:0] unbounded_q[$];

initial 
begin            

$display("a = %0d, b = %f, b = %0.3f, c = %0d",a,b,b,c);

wallet = '{2, 12.6};
wallet = '{coins:2, dollars:12.6};
wallet = '{default:0};
wallet = money'{int:1, dollars:12.4};
wallet_arr = '{'{1,2.3},'{2,3.1}};

a = int'(2.5*4.7);
// $rtoi and $itor

foreach (marr[i])
    foreach (marr[i][j])
        $display("marr[%0d][%0d]=%0d",i,j,marr[i][j]);

$display("%s",{firstname," ", lastname});

// $size(marr)
// $random

res = myarr.find(x) with (x>3);
res = myarr.find_index with (item==4);
res = myarr.find_first with (item>3 && item<8);
res = myarr.min(); //max, unique

myarr.reverse(); //sort, rsort, shuffle, randomize, print
// res = myarr.sum(); //product, and, or, xor

$display("res: %p",res);

unbounded_q = {1,2,3};
// unbounded_q[1:2] supports slicing [1:$] till end]
// unbounded_q.size(), pop_front(), pop_back(), push_front(i), push_back(i)
// class_name q[$]; class_name f = new(); q.push_back()

end

endmodule
