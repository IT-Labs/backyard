package com.itlabs.api.service;

import com.itlabs.api.entity.Items;
import java.io.File;
import java.time.ZoneOffset;
import org.springframework.stereotype.Service;

@Service
public class ItemRangServiceImpl implements ItemRangService {

  @Override
  public long getRang(Items item) {
    long result = 0;
    switch (item.getStatus()) {
      case DRAFT:
        result = 2;
        break;
      case DONE:
        result = 1;
        break;
      case IN_PROGRESS:
        result = item.getCreated().toEpochSecond(ZoneOffset.UTC);
        break;
      case CANCEL:
        result = -1;
        break;
      default:
        throw new IllegalStateException("Unexpected value: " + item.getStatus());
    }

    return result;
  }

  private static File makeFile(String filename) {
    if (filename != null && filename.length() >= 0) {
      return new File(filename);
    }
    return new File("default.name");
  }
}
