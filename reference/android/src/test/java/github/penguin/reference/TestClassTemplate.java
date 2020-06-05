package github.penguin.reference;

import github.penguin.reference.templates.$TemplateReferencePairManager.ClassTemplate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class TestClassTemplate implements ClassTemplate {
  final List<Object> lastMethodTemplateArguments = new ArrayList<>(1);

  @Override
  public String methodTemplate(String parameterTemplate) {
    lastMethodTemplateArguments.clear();
    lastMethodTemplateArguments.addAll(Collections.singletonList(parameterTemplate));
    return "tornado";
  }

  @Override
  public Integer getFieldTemplate() {
    return 0;
  }
}
