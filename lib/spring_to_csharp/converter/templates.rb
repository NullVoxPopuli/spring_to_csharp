module SpringToCSharp
  class Converter
    module Templates
      CSHARP_CLASS = ->(class_name, method_name, return_type, body){
%Q{
class #{class_name}{
  public static #{return_type} #{method_name}(){
    return #{body};
  }
}
}
      }
    end
  end
end
