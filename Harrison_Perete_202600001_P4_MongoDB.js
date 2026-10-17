// Run once in mongosh, using either the local connection or Atlas.
// Select the MongoDB database, not the PostgreSQL database.
db = db.getSiblingDB("library_events");

// Stop rather than inserting another copy of an existing exercise.
if (db.borrowing_events.countDocuments() !== 0) {
    throw new Error("borrowing_events already contains records. Check them before continuing.");
}

// Each document records one event. Member and copy details are snapshots.
printjson(db.borrowing_events.insertMany([
    {
        _id: "E001", event_type: "borrowed",
        occurred_at: ISODate("2026-10-01T09:00:00Z"),
        member: { membership_number: "M001", full_name: "Ada James" },
        copy: { barcode: "LIB002", title: "Things Fall Apart" },
        details: { due_at: ISODate("2026-10-08T09:00:00Z") }
    },
    {
        _id: "E002", event_type: "returned",
        occurred_at: ISODate("2026-10-17T12:00:00Z"),
        member: { membership_number: "M001", full_name: "Ada James" },
        copy: { barcode: "LIB002", title: "Things Fall Apart" },
        details: { condition: "good" }
    },
    {
        _id: "E003", event_type: "borrowed",
        occurred_at: ISODate("2026-10-17T14:00:00Z"),
        member: { membership_number: "M002", full_name: "Ben Cole" },
        copy: { barcode: "LIB003", title: "Things Fall Apart" },
        details: { due_at: ISODate("2026-10-24T14:00:00Z") }
    },
    {
        _id: "E004", event_type: "borrowed",
        occurred_at: ISODate("2026-10-15T09:00:00Z"),
        member: { membership_number: "M002", full_name: "Ben Cole" },
        copy: { barcode: "LIB001", title: "Things Fall Apart" },
        details: { due_at: ISODate("2026-10-22T09:00:00Z") }
    }
]));

// printjson shows each result when this file is run as a script.
// Q1: Four documents should have been saved.
printjson(db.borrowing_events.countDocuments());

// Q2: Show LIB002's events in the order they happened.
printjson(db.borrowing_events.find(
    { "copy.barcode": "LIB002" },
    { _id: 1, event_type: 1, occurred_at: 1, details: 1 }
).sort({ occurred_at: 1, _id: 1 }).toArray());

// Q3: Search a field inside the details document.
printjson(db.borrowing_events.find({ "details.condition": "good" }).toArray());
