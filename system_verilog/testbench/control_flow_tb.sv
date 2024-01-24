/*
while() begin end
for()
do while()
break; continue;

unique if: when no else cond or 2 if matches => error
    unique if()
    else if()
    else
priority if: 1st match is executed
    priority if()
    else if()
    else

When overlap in cases => error
    unique case()
    endcase

blocking: = (executes one after another in procedural block)
non blocking: <= (assignment schedules without blocking the executement of the following statements)

function byte sum(int a, int b) or (input int a, b, output res)
    return a+b;
endfunction

function int fn(ref int a) => passing val by reference
    a = a+5; return a;
endfunction

tasks are static var by default task automatic name makes it behave non static var
tasks can be declared outside the module
task name(input .., output c inout .. ); 
begin 
    c = a+b;
end
endtask

task vs function:
task:
    can have time delays/controls in it (#10)
    can have 0/more input arguments, inout or any
    can return multiple outputs
function:
    cannot have time delays/controls in it (#10)
    should have min 1 input arguments, no inout type
    can return only single val

fork join: Finishes when all child threads are over
fork join_any:	Finishes when any child thread gets over
fork join_none:	Finishes soon after child threads are spawned
disable fork; kills all the threads
wait fork; waits till all the fork threads are over and executes whatever is below it

Semaphore control access to the resource and known as mutex (mutual exclusion), cz only one can have access
Mailbox dedicated channel established bw 2 components to communicate
*/

typedef class transaction; //inform compiler that this class is defined later
typedef class generator;
typedef class driver;

module control_flow_tb;

bit clk=0;
int arr[5];
initial
begin
    // forever #5 clk=!clk;

    repeat(5) $display("repeat");
    
    foreach(arr[i]) arr[i]=i;
    foreach(arr[i]) $display("%0d",arr[i]);
end

event event_a, a,b,c;
//thread1
initial 
begin
    #20 ->event_a; //-> or ->>
    $display("[%0t] thread1: triggered event_a",$time);
end

//thread2
initial 
begin
    $display("[%0t] thread2: waiting for trigger event_a",$time);
    @(event_a); //@ or wait(event_a.triggered)
    $display("[%0t] thread2: after trigger from event_a",$time);
end

initial 
begin
    #1 $display ("[%0t ns] Start fork ...", $time);
    // Main Process: Fork these processes in parallel and wait until any one of them finish
    
    fork
        // Thread1 : Print this statement after 5ns from start of fork
        #5 $display ("[%0t ns] Thread1: Orange is named after orange", $time);
       
        // Thread2 : Print these two statements after the given delay from start of fork
        begin
            #2 $display ("[%0t ns] Thread2: Apple keeps the doctor away", $time);
            #4 $display ("[%0t ns] Thread2: But not anymore", $time);
        end

        // Thread3 : Print this statement after 10ns from start of fork
        #10 $display ("[%0t ns] Thread3: Banana is a good fruit", $time);
    
    join_any //join, join_any, join_none
        // Main Process: Continue with rest of statements once fork-join is exited
        $display ("[%0t ns] After Fork-Join", $time);
end


semaphore key;
/* 
key = new(n_keys)
key.get(n_keys); key.put(n_keys); key.try_get(n_keys);
get: if keys not available process are blocked
*/
task personA ();
    key.get (1);
    #20 
    key.put (1);
endtask

task personB ();
    #5 
    key.get (1);
    #10 
    key.put (1);
endtask

initial begin
    key = new (1); // Create only a single key; multiple keys are also possible
    fork
        personA (); // personA tries to get the room and puts it back after work
        personB (); // personB also tries to get the room and puts it back after w
        #25 personA (); // personA tries to get the room a second time
    join_none  
end

mailbox mbx;
/*mbx = new(num of msgs); mbx.put(msg), try_put(msg), get(msg_handler), try_get(msg_handler)
num() - returns number of messages in mailbox
peek(), try_peek() - copies withourt removing from the mailbox
mailbox #(string) mbx; - holds string type
mailbox #(byte) mbx; - holds byte type
*/
generator Gen;
driver Drv;
initial begin
    mbx = new ();
    Gen = new (mbx);
    Drv = new (mbx);
    fork
        #10 Gen.genData ();
        Drv.drvData ();
    join_none
end

endmodule

class transaction;
    rand bit [7:0] data;
    function display ();
        $display ("[%0t] Data = 0x%0h", $time, data);
    endfunction
endclass

// Generator class - Generate a transaction object and put into mailbox
class generator;
    mailbox mbx;
    function new (mailbox mbx);
        this.mbx = mbx;
    endfunction
    
    task genData ();
        transaction trns = new ();
        trns.randomize ();
        trns.display ();
        $display ("[%0t] [Generator] Going to put data packet into mailbox", $time);
        mbx.put (trns);
        $display ("[%0t] [Generator] Data put into mailbox", $time);
    endtask
endclass

// Driver class - Get the transaction object from Generator
class driver;
    mailbox mbx;
    function new (mailbox mbx);
        this.mbx = mbx;
    endfunction

    task drvData ();
        transaction drvTrns = new ();
        $display ("[%0t] [Driver] Waiting for available data", $time);
        mbx.get (drvTrns);
        $display ("[%0t] [Driver] Data received from Mailbox", $time);
        drvTrns.display ();
    endtask
endclass