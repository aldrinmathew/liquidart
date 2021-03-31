#set( $CAMEL_NAME = ${StringUtils.removeAndHump(${NAME})})
import 'package:liquidart/liquidart.dart';
import 'package:${PROJECT_NAME}/${PROJECT_NAME}.dart';

class ${CAMEL_NAME} extends ManagedObject<_${CAMEL_NAME}> implements _${CAMEL_NAME} {
  @override
  void willUpdate() {
  }
  
  @override
  void willInsert() {
  }
}
class _${CAMEL_NAME} {
  @managedPrimaryKey
  int id;
  
}
