def reverse(myList):
    if len(myList)==1:
        return myList
    return [myList.pop()] + reverse(myList)




def unique(myList):
    if len(myList)==1:
        return myList
    if myList[0] in myList[1:]:
        return unique(myList[1:])
    else:
        return [myList[0]]+unique(myList[1:])
    



def uniqueTuple(myList):
    myList.sort()
    if len(myList)==1:
        return myList
    if myList[0][0] == myList[1][0]:
        myList[0][1] = type(myList[0][1]) +1
        print (myList)
        return uniqueTuple(myList[1:])
    else:
        return [myList[0]]+unique(myList[1:])    

def makeTuple(myList):
    if len(myList)==1:
        return [(myList[0],0)]
    return [(myList[0],0)] + makeTuple(myList[1:])
        
    
def countFrequency(myList,k):
    if k not in myList:
        return 0
    else:
        if myList[0]==k:      
            return 1+countFrequency(myList[1:],k)
        else:
            return 0+countFrequency(myList[1:],k)
