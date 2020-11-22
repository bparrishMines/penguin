package github.penguin.reference.reference;

public interface Referencable<T> {
  ReferenceChannel<T> getReferenceChannel();
}
