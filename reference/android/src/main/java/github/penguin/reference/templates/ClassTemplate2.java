package github.penguin.reference.templates;

import github.penguin.reference.reference.ReferenceChannelManager;

public class ClassTemplate2 implements LibraryTemplate.$ClassTemplate2 {
  private static LibraryTemplate.$ClassTemplate2Channel channel;

  static void setupChannel(ReferenceChannelManager manager) {
    if (channel != null) return;
    channel =
        new LibraryTemplate.$ClassTemplate2Channel(
            manager,
            new LibraryTemplate.$ClassTemplate2Handler() {
              @Override
              LibraryTemplate.$ClassTemplate2 onCreateClassTemplate2(
                  ReferenceChannelManager manager, LibraryTemplate.$ClassTemplate2CreationArgs args)
                  throws Exception {
                return new ClassTemplate2();
              }
            });
  }
}
