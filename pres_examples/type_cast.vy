x: public(int128)            
y: public(decimal)
z: public(decimal)    
@external
def convert_type():
    # Explicit type casting
    self.y = 5.5
    self.x = 10
    self.z = convert(self.x, decimal) + self.y 

