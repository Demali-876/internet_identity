import Principal "mo:base/Principal";
actor {
  public query ({caller})func whoami() : async Text {
    Principal.toText(caller);
  };
};
