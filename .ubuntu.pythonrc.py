import os

# Fast way of clearing a python shell 
class Clear:
    def __repr__(self) -> str:
        os.system("clear")
        return ""

clear = Clear()

# The python shell's own exit:
_exit = exit 

# same for exit 
class Exit:
    def __repr__(self) -> str:
        _exit()
        return ""

exit = Exit()
