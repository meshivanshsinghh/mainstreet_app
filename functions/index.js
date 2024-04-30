const serviceAccount = require("./serviceAccountMainStreet.json");
const admin = require("firebase-admin");
const functions = require("firebase-functions");

const clientId = "sq0idp-2fQOp6SD7KXTB2iTH50wkw";
// const redirectUri = encodeURIComponent("mainstreet://");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

exports.authorizeSquare = functions.https.onRequest(async (req, res) => {
  const authorizeUrl = new URL("https://connect.squareup.com/oauth2/authorize");
  authorizeUrl.searchParams.set("client_id", clientId);
  authorizeUrl.searchParams.set("scope", "MERCHANT_PROFILE_READ");
  authorizeUrl.searchParams.set(
    "state",
    "https://backslashflutter.github.io/square_redirect_page/"
  );
  authorizeUrl.searchParams.set("session", false);
  res.redirect(authorizeUrl.toString());
});
