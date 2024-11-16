const functions = require("firebase-functions");
const onCall = require("firebase-functions/v2/https").onCall;
const HttpsError = require("firebase-functions/v2/https").HttpsError;
const getStorage = require("firebase-admin/storage").getStorage;
const admin = require("firebase-admin");
admin.initializeApp();

exports.uploadAvatarIconsToStorage = onCall( async (data) => {
    // const bucket = getStorage().bucket();
    return { message: "Hi fuckers" };
    // const {bucketURL, avatarIconsFolderName, imageData} = data;

    // if (!bucketURL || !avatarIconsFolderName || !imageData) {
    //     throw new Error("Missing required parameters.");
    // }

    // const folderPath = `${bucketURL}/${avatarIconsFolderName}`;
    // const uploadPromises = imageData.map(async (file) => {
    //     const filePath = `${folderPath}/${file.fileName}.${file.fileExtension}`;
    //     const fileBuffer = Buffer.from(file.data, "base64");
    //     const fileUpload = bucket.file(filePath);
    //     await fileUpload.save(fileBuffer, {
    //         metadata: { contentType: `image/${file.fileExtension}` },
    //     });
    //     return `Uploaded ${filePath}`;
    // });

    // return Promise.all(uploadPromises);
});

// MARK: Default Function
exports.helloWorld = onCall((request) => {
    const text = request.data.text;
    console.log(`Function called with data: ${text}`);
    return {"isCompleted": `${text}`};
});