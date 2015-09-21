package com.TAC.Model;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.SharedSessionContract;
import org.hibernate.Transaction;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class DBQuerrier {
	static SessionFactory sessionFactory;
	static Configuration configuration;

	private static Session sessionStart() {
		if (sessionFactory == null) {
			configuration = new Configuration().configure();
			StandardServiceRegistry standardServiceRegistry = new StandardServiceRegistryBuilder()
					.applySettings(configuration.getProperties()).build();
			sessionFactory = configuration.buildSessionFactory(standardServiceRegistry);
		}
		return (Session) sessionFactory.openSession();
	}

	public static String getDeviceList(String type) {
		Session session = sessionStart();
		String hql = "from Iteminfo where type like ? ";
		Query query = ((SharedSessionContract) session).createQuery(hql);
		query.setString(0, type+'%');
		String result = "[";
		List<Iteminfo> infos = query.list();
		// if (infos.size() == 0)
		// return null;
		// System.out.println(users.get(0).getEmail());

		for (int i = 0; i < infos.size(); i++) {
			Iteminfo iteminfo = infos.get(i);
			if (iteminfo.id == -822)
				continue;
			if (iteminfo.leftcount > 0) {
				result = result + iteminfo.id + "," + iteminfo.name + "," + iteminfo.description + "," + iteminfo.type
						+ "," + iteminfo.count + "," + iteminfo.leftcount;
				if (i != infos.size() - 1)
					result = result + "|";
			}
		}
		result += "]";
		return result;
	}

	public static String getRecordList() {
		Session session = sessionStart();
		String hql = "from Borrowrecord";
		Query query = ((SharedSessionContract) session).createQuery(hql);
		String result = "[";

		List<Borrowrecord> records = query.list();
		// System.out.println(records.size());

		for (int i = 0; i < records.size(); i++) {
			Borrowrecord record = records.get(i);
			// check 30 days and return status
			// done
			long currentTime = new Date().getTime();
			if (!(record.returnDate == null)) {
				if (currentTime - record.returnDate.getTime() > 30 * 24 * 60 * 60 * 1000) // 30*24*60*60*1000
																							// ms
					continue;
			}
			result = result + record.recordId + "," + record.borrowerName + "," + record.tele + ","
					+ (record.itemId == null || record.itemId == 0 ? "" : record.itemId) + ","
					+ (record.itemName == null ? "" : record.itemName) + ","
					+ (record.itemInfo == null ? "" : record.itemInfo) + "," + record.borrowDate.getTime() + ","
					+ (record.returnDate == null ? 0 : record.returnDate.getTime()) + "," + record.number;
			if (i < records.size() - 1) {
				result += "|";
			}
		}

		result += "]";
		return result;
	}

	public static String getDevice(String itemId) {
		Session session = sessionStart();
		String hql = "from Iteminfo where id = ? ";
		Query query = ((SharedSessionContract) session).createQuery(hql);

		int itemIdInt = 0;
		try {
			itemIdInt = Integer.parseInt(itemId);
		} catch (Exception e) {
			// TODO: handle exception
			return "[]";
		}
		query.setInteger(0, itemIdInt);
		String result = "[";
		Iteminfo iteminfo = (Iteminfo) query.uniqueResult();

		if (iteminfo != null) {
			result = result + iteminfo.id + "," + iteminfo.name + "," + iteminfo.description + "," + iteminfo.type + ","
					+ iteminfo.count + "," + iteminfo.leftcount;
		}
		result += "]";
		return result;
	}

	public static String getRecord(String recordId) {
		Session session = sessionStart();
		String hql = "from Borrowrecord where recordId = ?";
		Query query = ((SharedSessionContract) session).createQuery(hql);

		int recordIdInt = 0;
		try {
			recordIdInt = Integer.parseInt(recordId);
		} catch (Exception e) {
			// TODO: handle exception
			return "[]";
		}
		query.setInteger(0, recordIdInt);
		String result = "[";

		Borrowrecord record = (Borrowrecord) query.uniqueResult();
		// System.out.println(records.size());

		if (record != null) {
			result = result + record.recordId + "," + record.borrowerName + "," + record.tele + ","
					+ (record.itemId == null || record.itemId == 0 ? "" : record.itemId) + ","
					+ (record.itemName == null ? "" : record.itemName) + ","
					+ (record.itemInfo == null ? "" : record.itemInfo) + "," + record.borrowDate.getTime() + ","
					+ (record.returnDate == null ? 0 : record.returnDate.getTime()) + "," + record.number;
		}

		result += "]";
		return result;
	}

	public static String borrowItem(String command) {
		Session session = sessionStart();
		String[] parars = command.split(",");
		Borrowrecord br = null;
		String ii = "";
		int borrowCount = 0;
		int leftCount = 0;

		try {
			borrowCount = Integer.parseInt(parars[5]);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("problem1:para error");
			return "[0]";
		}

		if ("".equals(parars[2])) {
			br = new Borrowrecord(parars[0], parars[1], 0, parars[3], parars[4], new Date(), null, borrowCount);
		} else {
			ii = getDevice(parars[2]);
			if (!"[]".equals(ii)) {
				String[] infos = ii.split(",");
				String leftCountString = infos[5].substring(0, infos[5].length() - 1);
				leftCount = Integer.parseInt(leftCountString);
				if (leftCount < 1 || leftCount < borrowCount || borrowCount < 1) {
					System.out.println("problem2:wrong number");
					return "[0]";
				}
				System.out.println(infos[2]);
				br = new Borrowrecord(parars[0], parars[1], Integer.parseInt(parars[2]), infos[1], infos[2], new Date(),
						null, borrowCount);
			} else {
				System.out.println("problem4:no such item");
				return "[0]";
			}
		}

		Transaction tx = session.beginTransaction();

		try {
			session.save(br);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("problem3:save error,maybe null properties");
			return "[0]";
		}

		tx.commit();

		// did save then update count
		DBQuerrier.editLeftNumber(parars[2] + "," + (leftCount - borrowCount));

		return "[1]";
	}

	public static String returnItem(String recordId) {
		System.out.println("what happened");

		String record = DBQuerrier.getRecord(recordId);
		if (record.equals("[]"))
			return "[0]";

		String[] paras = record.split(",");
		// if(!("0".equals(paras[paras.length-2])))
		// return "[0]";

		int borrowCount = 0;
		try {
			borrowCount = Integer
					.parseInt((paras[paras.length - 1].substring(0, paras[paras.length - 1].length() - 1)));
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println("woca" + borrowCount);
		Session session = sessionStart();
		Transaction tx = session.beginTransaction();
		String hql = "update Borrowrecord br set br.returnDate = ? where br.recordId = ?";
		Query query = ((SharedSessionContract) session).createQuery(hql);

		int recordIdInt = 0;

		try {
			recordIdInt = Integer.parseInt(recordId);
		} catch (Exception e) {
			// TODO: handle exception
			return "[0]";
		}
		Date currenTimeDate = new Date();
		query.setTimestamp(0, currenTimeDate);
		query.setInteger(1, recordIdInt);

		int resInt = query.executeUpdate();
		tx.commit();
		session.close();

		// return done , update count
		if (!("".equals(paras[3]))) {
			session = sessionStart();
			tx = session.beginTransaction();
			hql = "update Iteminfo ii set ii.leftcount = ii.leftcount + ? where ii.id = ?";
			query = ((SharedSessionContract) session).createQuery(hql);
			query.setInteger(0, borrowCount);
			int itemIdInt = 0;
			itemIdInt = Integer.parseInt(paras[3]);
			query.setInteger(1, itemIdInt);
			query.executeUpdate();
			tx.commit();
			session.close();
		}

		return "[" + resInt + "]";
	}

	public static String adminLogin(String password) {
		Session session = sessionStart();
		String hql = "from Iteminfo where id = ? ";
		Query query = ((SharedSessionContract) session).createQuery(hql);

		query.setInteger(0, -822);
		String result = "[";
		Iteminfo iteminfo = (Iteminfo) query.uniqueResult();

		if (iteminfo != null) {
			result += (password.equals(iteminfo.name) ? 1 : 0);
		} else {
			result += 0;
		}
		result += "]";
		return result;
	}

	public static String getDeviceListAsAdmin(String type) {
		// return "8 admin "+type;
		Session session = sessionStart();
		String hql = "from Iteminfo where type = ? ";
		Query query = ((SharedSessionContract) session).createQuery(hql);
		String result = "[";

		query.setString(0, type);
		List<Iteminfo> infos = query.list();
		// if (infos.size() == 0)
		// return null;
		// System.out.println(users.get(0).getEmail());

		for (int i = 0; i < infos.size(); i++) {
			Iteminfo iteminfo = infos.get(i);
			result = result + iteminfo.id + "," + iteminfo.name + "," + iteminfo.description + "," + iteminfo.type + ","
					+ iteminfo.count + "," + iteminfo.leftcount;
			if (i != infos.size() - 1)
				result = result + "|";

		}
		result += "]";
		return result;
	}

	public static String editLeftNumber(String command) {
		Session session = sessionStart();
		Transaction tx = session.beginTransaction();
		String hql = "update Iteminfo ii set ii.leftcount = ? where ii.id = ?";
		Query query = ((SharedSessionContract) session).createQuery(hql);

		String[] coms = command.split(",");

		int itemId = 0;
		int itemCount = -1;

		try {
			itemId = Integer.parseInt(coms[0]);
			itemCount = Integer.parseInt(coms[1]);
		} catch (Exception e) {
			// TODO: handle exception
			return "[0]";
		}

		System.out.println(command + " " + itemId + " " + itemCount);

		query.setInteger(0, itemCount);
		query.setInteger(1, itemId);

		int resInt = query.executeUpdate();
		tx.commit();
		session.close();

		return "[" + resInt + "]";
	}

	public static String wrongCode(String command) {
		return "[]";
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String result = "";
		result = DBQuerrier.getDeviceList("ios");
		// result =
		// DBQuerrier.borrowItem("全栈攻城狮薛哥,13194949494,,羽毛球,一个长得很可爱的羽毛球希望不要轻易狗带,1");
		// result = DBQuerrier.returnItem("4");
		// System.out.println(result);
	}

}
