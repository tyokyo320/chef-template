# my_opensearch_cookbook/attributes/default.rb

default['my_opensearch_cookbook']['opensearch_version'] = '1.0.0'
default['my_opensearch_cookbook']['opensearch_dashboards_version'] = '1.0.0'
default['my_opensearch_cookbook']['opensearch_config'] = {
  'option1' => 'value1',
  'option2' => 'value2',
  # 其他配置参数
}
default['my_opensearch_cookbook']['opensearch_dashboards_config'] = {
  'option1' => 'value1',
  'option2' => 'value2',
  # 其他配置参数
}
