import time
print("\033c\033[43;30m\n")

class simu:
    def __init__(self):
        self.reg=["XMM0","XMM1","XMM2","XMM3","XMM4","XMM5","DS","ES"]
        self.values=[0,0,0,0,0,0,0,0,0]
        self.stack=[]
    def pushs(self,s):
        s=s.upper()
        ss=0
        a=False
        counter=0
        for n in self.reg:
            if n==s:
                a=True
                ss=self.values[counter]
            counter+=1
        if a:
            self.stack=self.stack+[ss]
        else:
            try:
                i=int(s)
                self.stack=self.stack+[i]
            except:
                print("error on register")
    def pops(self,s):
        s=s.upper()
        ss=0
        a=False
        counter=0
        for n in self.reg:
            if n==s:
                a=True
                self.values[counter]=self.stack.pop()
            counter+=1
        if a:
            pass
        else:
            print("error on register")
    def mov(self,s,ss):
        s=s.upper()
        ss=ss.upper()
        r=0
        sss=0
        a=False
        counter=0
        i=0
        for n in self.reg:
            if n==ss:
                a=True
                i=self.values[counter]
            counter+=1
                
        if a:
            pass
        else:
            try:
                i=int(ss)
                a=True
            except:
                print("error")
        counter=0
        if a:
            a=False
            
            for n in self.reg:
                if n==s:
                    a=True
                    
                    self.values[counter]=i
                counter+=1
            if a:
                 pass
            else:
                 print("error on register")
    def stacks(self):
        print(self.stack)
    def register(self,s):
        s=s.upper()
        
        r=0
        ss=0
        a=False
        counter=0
        i=0
        for n in self.reg:
            if n==s:
                a=True
                print(self.values[counter])
            counter+=1
                
s=simu()
s.mov("ES","10")
s.mov("XMM0","ES")
s.register("XMM0")
